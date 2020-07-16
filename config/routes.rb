Rails.application.routes.draw do
  
  resources :wishes, only: %i[index create destroy update]
  # root to: 'wishes#index'
  resources :users
end
