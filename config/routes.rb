Rails.application.routes.draw do
  resources :recipes
  resources :sessions, only: [:new, :create]
  resources :users
  resources :recipes do
    put :favorite, on: :member
  end
  
  get '/user_home', to: 'welcome#user_home'

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout' => 'sessions#destroy', as: 'logout' 
  
  root 'welcome#home'

end
