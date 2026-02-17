Rails.application.routes.draw do
  # Página inicial: Se estiver logado vai para home, se não, para login
  root "home#index"

  # Rotas de Autenticação (Sessões)
  get    "/login",   to: "sessions#new"     # Página de login
  post   "/login",   to: "sessions#create"  # Ação de entrar
  delete "/logout",  to: "sessions#destroy" # Ação de sair

  # Rotas de Registo (Utilizadores)
  get    "/signup",  to: "users#new"        # Página de registo
  resources :users, except: [ :new ]          # Outras ações de user (edit, show, etc)

  # Recursos Principais
  resources :events
  resources :equipment
  resources :categories
  resources :clients
  resources :home, only: [ :index ]

  # Recursos Aninhados (Nested Resources)
  resources :rentals do
    resources :rental_items
    resources :payments
  end

  # Health Check
  get "up" => "rails/health#show", as: :rails_health_check
end
