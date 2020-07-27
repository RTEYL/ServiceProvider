Rails.application.routes.draw do
  root 'sessions#home'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  delete 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  resources :services, only: [:index] do
    resources :reviews, except: [:show, :new, :create]
  end
  resources :users, except: [:index] do
    resources :service_requests
    resources :services, except: [:show, :index], shallow:true do
      resources :reviews, only: [:new, :create, :edit]
    end
  end

end
