Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :users, only: :show
  resources :posts do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
  resources :tags do
    get "posts", to: "posts#tag"
  end
end