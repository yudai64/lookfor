Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#home"
  resources :users, only: [:index, :show, :new, :create]
  resource :profile, only: [:show, :edit, :update, :destroy]
  resources :posts do
    resources :comments, only: [:create]
  end
  get "/login",  to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
