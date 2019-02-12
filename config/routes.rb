Rails.application.routes.draw do
  root 'welcome#index'

  resources :welcome, only: :index
  resources :items, only: :index
  resources :users, only: [:index, :create]

  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'merchant/users#show'
  get '/admin/dashboard', to: 'admin/users#show'
  get '/register', to: 'users#new'
  get '/profile', to: 'registered/users#show'

  scope :profile, module: :registered, as: :profile do
    resources :orders, only: [:index]
  end

  namespace :admin do
    resources :users, only: [:index]
  end
end
