Rails.application.routes.draw do
  root to: "pages#index"
  resources :species

  resources :alliances do
    resources :characters
  end
  resources :homeworlds do
    resources :characters
  end
  resources :characters
  resources :vehicles
  
  get "pages" => "pages#index"
end
