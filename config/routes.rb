Rails.application.routes.draw do
  resources :recipes
  resources :ingredients 
  resources :items
  resources :users, only: [:new, :create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
