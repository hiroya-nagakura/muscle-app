Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_login'
    get 'users', to: 'users/registrations#new'
  end

  resources :users, only: [:show] do
    resources :records
    resources :bodyweights, only: %i[index create update destroy]
  end
  resources :articles do
    resources :favorites, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end
  resources :relationships, only: %i[create destroy]
end
