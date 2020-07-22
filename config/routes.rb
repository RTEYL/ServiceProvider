Rails.application.routes.draw do

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resources :sessions
  resources :services
  resources :users, only: [:show]
  resources :providers
  resources :service_requests
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
