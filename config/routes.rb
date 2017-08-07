Rails.application.routes.draw do
  resources :species
  root to: 'characters#index'

  resources :alliances do
    resources :characters
  end
  resources :homeworlds do
    resources :characters
  end
  resources :characters
end
