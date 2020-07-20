Rails.application.routes.draw do
  
#  Chat function
  resources :conversation, only: [:index, :create]
  resources :messages, only: [:create]
  mount ActionCable.server => '/cable'

  post "/login", to: "user_token#create"
  get "/status", to: "status#index"
  get "/status/user", to: "status#user"
  post "/sign-up", to: "users#create"
  resources :wishes, only: %i[index create destroy update show]
  # root to: 'wishes#index'
  # resources :users
end
