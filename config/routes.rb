Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'user/callbacks' }

  resources :user, controller: 'user', only: [:show] do
    root to: 'user/profile#cabinet'
  end

  namespace :user do
    resources :courses, except: [:index] do
      resource :subscriptions, only: [:create, :destroy]
    end

    namespace :profile do
      get 'signed_up_with_social'
      put 'edit_signed_up_with_social'
    end
  end

    namespace :profile do
      get 'signed_up_with_social'
      put 'edit_signed_up_with_social'
    end

  resources :courses, only: [:show, :index]
  root to: 'static_pages#index'
end
