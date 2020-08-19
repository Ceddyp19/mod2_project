Rails.application.routes.draw do
  resources :recipes
  resources :ingredients 
  resources :items
  resources :users, only: [:new, :create]
  get '/user_home', to: 'welcome#user_home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout' => 'sessions#destroy' 
  root 'welcome#home'

end
