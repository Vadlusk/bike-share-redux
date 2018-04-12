Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :carts, only: [:create, :destroy]
  resources :trips, only: [:index, :show]
  resources :conditions, only: %i[index show]
  resources :stations, only: [:index, :show], param: :slug
  resources :accessories, only: [:show]
  get '/bike-shop', to: 'accessories#index'

  root controller: 'welcome', action: :index

  get  '/cart',      to: 'carts#show'
  get  '/register',  to: 'users#new'
  post '/register',  to: 'users#create'
  get  '/dashboard', to: 'users#show'

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  namespace :admin do
    get '/dashboard', to: 'users#show'
    resources :stations, only: [:update, :edit, :destroy, :new, :create]
  end
end
