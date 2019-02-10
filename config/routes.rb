Rails.application.routes.draw do
  root 'welcome#index'

  resources :welcome, only: :index
  resources :items, only: :index
  resources :users, only: :index

  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/register', to: 'users#new'
  post '/reegister', to: 'users#create'
end
