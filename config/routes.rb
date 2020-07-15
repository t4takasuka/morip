Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :comments, only: :create
  end
  resources :users, only: :show
  
  resources :tags do
    get "posts", to: "posts#tag"
  end
end