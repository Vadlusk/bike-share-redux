Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips, only: [:index, :show]
  resources :conditions, only: %i[index show]
  
  root controller: 'welcome', action: :index

  get   '/login',  to: 'sessions#new'
end
