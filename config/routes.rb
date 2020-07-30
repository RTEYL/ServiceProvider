Rails.application.routes.draw do
  root 'welcome#home'

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}

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
