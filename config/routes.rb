Rails.application.routes.draw do
  root to: 'users#new'
  resources :users
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
