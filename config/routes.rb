Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "session/new"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :authors
  resources :publishers
  put "admin/:id", to: "users#make_admin", as: "make_admin"
  resources :books do
    member do
      get :like, :unlike
    end
  end
  resources :comments
  resources :relationships, only: [:create, :destroy]
  resources :likes
end
