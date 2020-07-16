Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :posts do
    resources :comments, only: :create
  end
  
  resources :tags do
    get "posts", to: "posts#tag"
  end
  
  resources :relationships, only: [:create, :destroy]
end