Rails.application.routes.draw do
  
#  Chat function
  resources :conversations, only: [:index, :create]
  resources :messages, only: [:create]
  mount ActionCable.server => '/cable'

  post "/login", to: "user_token#create"
  put "/wishes/image/:id", to: "wishes#update_image"
  get "/status", to: "status#index"
  get "/status/user", to: "status#user"
  post "/sign-up", to: "users#create"
  resources :wishes, only: %i[index create destroy update show] do
    resources :comments, only: [:index, :create, :destroy]
  end
  
  # root to: 'wishes#index'
  # resources :users
end
