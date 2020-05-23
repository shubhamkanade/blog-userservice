Rails.application.routes.draw do
  namespace :api do
    resources :users, only: %i[create show]
  end
  post 'login', to: 'sessions#create'
end
