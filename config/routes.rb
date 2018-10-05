Rails.application.routes.draw do
  root "books#index"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "session/new"
  get "/login", to: "session#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"
  put "admin/:id", to: "users#make_admin", as: "make_admin"
  put "admin/request/:id", to: "requests#accept_request", as: "accept_request"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books do
    resources :user_reviews
    member do
      get :like, :unlike
      get :follow, :unfollow
    end
  end
  resource :cart, only: [:show]
  resources :authors
  resources :categories
  resources :comments
  resources :follows
  resources :likes
  resources :publishers
  resources :relationships, only: [:create, :destroy]
  resources :request_details, only: [:create, :update, :destroy]
  resources :requests
end
