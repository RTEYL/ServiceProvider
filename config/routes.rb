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

end
