Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trips, only: [:index]
  resources :conditions, only: %i[index]
end
