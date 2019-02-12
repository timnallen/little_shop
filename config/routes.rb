Rails.application.routes.draw do
  root 'welcome#index'

  resources :welcome, only: :index
  resources :items, only: :index
  resources :users, only: [:index, :create]

  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/dashboard', to: 'merchant/users#show'
  get '/register', to: 'users#new'
  get '/profile', to: 'registered/users#show'
end
