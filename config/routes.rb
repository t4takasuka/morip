Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "posts#index"
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :posts do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end

  resources :tags do
    get "posts", to: "posts#tag"
  end
  
  resources :relationships, only: [:create, :destroy]
end