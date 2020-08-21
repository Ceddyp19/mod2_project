Rails.application.routes.draw do
  post 'favorites/create'
  delete 'favorites/destroy'
  resources :recipes
  resources :sessions, only: [:new, :create]
  resources :users
  # resources :favorites, only: [:create, :destroy]
  # resources :recipes do
  #   put :favorite, on: :member
  # end
  get '/user_home', to: 'welcome#user_home'

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout' => 'sessions#destroy', as: 'logout' 
  
  root 'welcome#home'
  get '/about', to: 'welcome#about'
  get '/analytics', to: 'welcome#analytics'
  get '/quiz', to: 'quiz#intro'
  get '/quiz/play', to: 'quiz#play'
  get '/quiz/test', to: 'quiz#test'
end
