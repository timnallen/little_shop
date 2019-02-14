Rails.application.routes.draw do
  root 'welcome#index'

  resources :welcome, only: :index

  resources :items, only: [:index, :show]
  resources :users, only: [:index, :create, :update]

  get '/cart', to: 'cart#show'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'merchant/users#show'
  get '/admin/dashboard', to: 'admin/users#show'
  get '/register', to: 'users#new'
  get '/profile', to: 'registered/users#show'
  get '/profile/edit', to: 'registered/users#edit'

  scope :profile, module: :registered, as: :profile do
    resources :orders, only: [:index]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :update]
  end
end
