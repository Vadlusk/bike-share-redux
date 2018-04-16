Rails.application.routes.draw do
  resources :carts, only: [:create, :destroy, :update, :edit, :show]
  resources :trips, only: [:index, :show]
  resources :conditions, only: [:index, :show]
  resources :stations, only: [:index, :show], param: :slug
  resources :accessories, only: [:show]
  resources :orders, only: [:create, :show, :update]
  resources :stationsdashboard, only: [:index]

  get '/stations-dashboard', to: 'stations_dashboard#index'

  get '/bike-shop', to: 'accessories#index'

  root controller: 'welcome', action: :index

  get  '/cart',      to: 'carts#show'
  get  '/register',  to: 'users#new'
  post '/register',  to: 'users#create'
  get  '/dashboard', to: 'users#show'
  get '/trips-dashboard', to: 'trips_dashboard#index'
  get '/conditions-dashboard', to: 'conditions_dashboard#index'

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  namespace :admin do
    get '/dashboard',            to: 'users#show'
    resources :stations, only: [:update, :edit, :destroy, :new, :create]
    resources :conditions, only: [:new, :create, :edit, :update, :destroy]
    resources :trips, only: [:new, :create, :edit, :show, :update, :destroy]
  end
end
