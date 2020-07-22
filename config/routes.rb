Rails.application.routes.draw do
  root 'sessions#home'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  delete 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  resources :services, only: [:index]
  resources :users, only: [:show] do
    resources :service_requests, except: [:show]
  end
  resources :providers do
    resources :services, except: [:index]
    resources :service_requests, only: [:index, :edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
# providers/id/services/id
# providers/id/services/new
# users/id/service_requests
# users/id/service_requests/new
# providers/id/service_requests