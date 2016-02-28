Rails.application.routes.draw do
  devise_for :user

  resources :user, controller: 'user', only: [:show] do
    root to: 'user#cabinet'
  end

  namespace :user do
    resources :courses, except: [:index]
  end

  resources :courses, only: [:show, :index]
  root to: 'static_pages#index'
end
