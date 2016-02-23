Rails.application.routes.draw do
  devise_for :user

  resources :user, controller: 'user', only: [:show] do
    root to: 'user#show'
    resources :courses, controller: 'user/courses', except: [:index]
  end

  root to: 'static_pages#index'
  resources :courses, only: [:show, :index]
end
