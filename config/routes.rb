Rails.application.routes.draw do
  root to: 'landing_page#index'
  resources :questions, only: [:new, :create]
end
