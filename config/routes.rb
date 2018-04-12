Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :carts, only: [:create, :destroy, :update, :edit]
  resources :trips, only: [:index, :show]
  resources :conditions, only: %i[index show]
  resources :stations, only: [:index, :show], param: :slug
  resources :accessories, only: [:show]
  get '/bike-shop', to: 'accessories#index'

  root controller: 'welcome', action: :index

<<<<<<< HEAD
  get  '/cart',      to: 'carts#show'
=======
>>>>>>> Add authorization tests for admin login. Add admin namespace to routes, with admin/user#show sub-resource. Update sessions controller to redirect admin to admin_dashboard_path. Add Admin::UsersController and admin/users#show view.
  get  '/register',  to: 'users#new'
  post '/register',  to: 'users#create'
  get  '/dashboard', to: 'users#show'

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  namespace :admin do
    get '/dashboard', to: 'users#show'
<<<<<<< HEAD
    resources :stations, only: [:update, :edit, :destroy, :new, :create]
=======
>>>>>>> Add authorization tests for admin login. Add admin namespace to routes, with admin/user#show sub-resource. Update sessions controller to redirect admin to admin_dashboard_path. Add Admin::UsersController and admin/users#show view.
  end
end
