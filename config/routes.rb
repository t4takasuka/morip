Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  devise_scope :user do
    post 'user/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: "posts#index"
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  resources :tags do
    get "posts", to: "posts#tag"
  end
  
  resources :relationships, only: [:create, :destroy]
end