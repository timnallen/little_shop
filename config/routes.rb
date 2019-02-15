Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :carts, only: [:create]

  resources :users, only: [:create, :update]

  get '/cart', to: 'carts#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'merchant/users#show'
  get '/register', to: 'users#new'
  get '/merchants', to: 'users#index'

  scope :profile, as: :profile do
    resources :orders, only: [:index]
    get '/', to: 'users#show'
    get '/edit', to: 'users#edit'
  end

  namespace :admin do
    resources :users, only: [:index, :show, :update, :edit]
    put '/users/:id/enable', to: 'users#enable', as: :enable_user
    put '/users/:id/disable', to: 'users#disable', as: :disable_user
    get '/dashboard', to: 'dashboard#show'
  end
end
