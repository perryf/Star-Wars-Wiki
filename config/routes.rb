Rails.application.routes.draw do
  root to: 'characters#index'
  resources :species

  resources :alliances do
    resources :characters
  end
  resources :homeworlds do
    resources :characters
  end
  resources :characters
  resources :vehicles
end
