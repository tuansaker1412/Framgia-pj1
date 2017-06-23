Rails.application.routes.draw do
  root "static_pages#home"
  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "index", to: "static_pages#index"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy] do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
end
