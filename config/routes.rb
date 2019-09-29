Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks",
  }
  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end
  root to: "static_pages#home"
  resources :users, only: [:index, :show]
  resource :profile, only: [:show]
  resources :posts do
    resources :comments, only: [:create]
  end
end
