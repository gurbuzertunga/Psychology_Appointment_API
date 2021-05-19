Rails.application.routes.draw do
  resources :consultancies
  resources :appointments
  post 'auth/login', to: 'authentication#create'
  post 'signup', to: 'users#create'
end