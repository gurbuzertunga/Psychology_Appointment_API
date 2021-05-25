Rails.application.routes.draw do
  resources :consultancies
  resources :appointments
  resource :authentication, only: [:create], to: 'authentication#create'
  resources :users, only: [:create], to: 'users#create'
end