require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  devise_for :user, controllers: { omniauth_callbacks: 'user/callbacks' } do
    root to: 'user/profile#cabinet'
  end

  constraints(id: /[0-9]+/) do
    resources :user, controller: 'user', only: [:show] do
      root to: 'user/courses#index'
    end
  end

  namespace :user do
    resources :my_advancements, only: [:index, :show, :edit, :update]
    resource  :subscription, only: [:show]
    resources :courses do
      resource  :subscriptions, only: [:create, :destroy]
      resource  :visibility, controller: :course_visibility, only: :update
      resources :lessons, except: :index do
        resources :advancements, only: [:index, :show] do
          controller :advancements_state do
            post :approve
            post :reject
          end
        end
      end
    end

    namespace :lessons_sorting do
      get '/courses/:id', action: :prepare
      get '/courses/:id/sort', action: :sort, as: :sort
    end

    post '/:id/courses/:courses_id/prohibition', to: 'exclusions#update', as: :create_course_prohibition

    resource :profile, only: [:edit, :update], controller: :profile
    resource :signed_up_with_social, only: [:edit, :update]

    resources :newsfeeds, only: [:index, :destroy]
  end

  resources :courses, only: [:show, :index] do
    resources :lessons, only: [:show] do
      # Rails creating resource URL-helper as 'course_lesson_create_advancement_index'
      # and URI as '/courses/:course_id/lessons/:lesson_id/advancement(.:format)'
      # and controller advancement#create
      # resource :advancement, only: [:create]
      post 'advancement', to: 'advancement#create', as: :create_advancement
    end
  end

  namespace :api do
    namespace :v1 do
      resources :courses, only: :index

      constraints(id: /[0-9]+/) do
        resources :user, only: [] do
          resources :courses, module: :user, only: :index
        end
      end

      resource :user, only: [] do
        scope  module: :user do
          resources :subscriptions, only: [:index]
          resource :profile, only: [:update]
          resources :course, only: [] do
            resource :subscription, only: [:create, :destroy]
          end

          get 'sign_in', to: 'authentication#show'
          post 'sign_up', to: 'authentication#create'
        end
      end
    end
  end

  root to: 'static_pages#index'
end
