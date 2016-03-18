Rails.application.routes.draw do
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
      resource  :visibility, controller: :course_visibility, only: [:update]
      resources :lessons, except: [:index] do
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

    post '/:id/courses/:courses_id/prohibition', to: 'exclusions#create', as: :create_course_prohibition

    resource :profile, only: [:edit, :update], controller: :profile do
      get 'signed_up_with_social'
      put 'edit_signed_up_with_social'
    end
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

  root to: 'static_pages#index'
end
