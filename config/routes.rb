Rails.application.routes.draw do
  resources :consultancies
  resources :appointments
  post 'auth/login', to: 'authentication#authenticate'
end