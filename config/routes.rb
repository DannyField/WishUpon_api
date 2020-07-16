Rails.application.routes.draw do
  resources :wishes, only: %i[index create destroy update]
end
