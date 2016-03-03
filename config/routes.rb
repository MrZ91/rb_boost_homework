Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'user/callbacks' }

  constraints(id: /[0-9]+/) do
    resources :user, controller: 'user', only: [:show] do
      root to: 'user/courses#index'
    end
  end

  namespace :user do
    resources :courses
    namespace :profile do
      get 'signed_up_with_social'
      put 'edit_signed_up_with_social'
    end
  end

  resources :courses, only: [:show, :index]
  root to: 'static_pages#index'
end
