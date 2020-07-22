Rails.application.routes.draw do
  root 'sessions#home'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  delete 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  resources :sessions
  resources :services
  resources :users, only: [:show]
  resources :providers
  resources :service_requests
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
