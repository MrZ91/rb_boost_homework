Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'user/callbacks' }

  namespace :user do
    resource :subscription, only: [:show]

    resources :courses, except: [:index] do
      resource :subscription, only: [:create, :destroy]
      resource :visibility, controller: :course_visibility, only: [:update]
    end

    get 'cabinet', to: 'profile#cabinet'
    get 'signed_up_with_social', to: 'profile#signed_up_with_social'
    put 'edit_signed_up_with_social', to: 'profile#edit_signed_up_with_social'
    post '/:id/courses/:courses_id/prohobition', to: 'exclusions#create', as: :create_course_prohibition
  end

  resources :courses, only: [:show, :index]
  root to: 'static_pages#index'
end
