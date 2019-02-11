Rails.application.routes.draw do
  root 'welcome#index'

  resources :welcome, only: :index
  resources :items, only: :index
  resources :users, only: [:index, :create]
  resources :sessions, only: :create

  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  get '/register', to: 'users#new'
  get '/profile', to: 'registered/users#show'
end
