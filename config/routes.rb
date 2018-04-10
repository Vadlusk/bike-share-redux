Rails.application.routes.draw do
  resources :trips, only: [:index, :show]
  resources :conditions, only: %i[index]
end
