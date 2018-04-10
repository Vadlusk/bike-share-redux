Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root controller: 'welcome', action: :index

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'

  get  '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/dashboard', to: 'users#show'

  resources :trips, only: [:index]
end
