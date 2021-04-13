Rails.application.routes.draw do
  resources :consultancies do
    resources :appointments
  end
end