Rails.application.routes.draw { resources :events
  resources :equipment
  resources :users
  resources :categories
  resources :rentals do
      resources :rental_items
      resources :payments
  end
  resources :clients
  resources :home
  # resources :rental_items
  # resources :payments
  root "home#index"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check }
