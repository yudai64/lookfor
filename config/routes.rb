Rails.application.routes.draw do
  root to: 'users#new'
  resource :user, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show]
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
