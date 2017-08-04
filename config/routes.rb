Rails.application.routes.draw do
  root to: 'alliances#index'

  resources :alliances do
    resources :charaters
  end
  resources :charaters
end
