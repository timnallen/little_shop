Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, only: [:index, :show]

  resources :carts, only: [:create]

  resources :users, only: [:create, :update]

  get '/cart', to: 'carts#show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/merchants', to: 'users#index'

  scope :dashboard, as: :dashboard do
    get '/', to: 'merchant/users#show'
  end

  namespace :merchant do
    resources :items, only: [:index, :new, :create, :edit, :update]
    put '/items/:id/enable', to: 'items#enable', as: :enable_item
    put '/items/:id/disable', to: 'items#disable', as: :disable_item
  end

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
    resources :merchants, only: :show
  end
end
