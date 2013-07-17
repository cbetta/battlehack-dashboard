Dashboard::Application.routes.draw do
  resources :tweets
  resource :timer do
    member do
      get "status"
    end
  end

  resources :notifications do
    collection do
      get "latest"
    end
  end
  get '/admin', to: 'admin#index'

  root "dashboard#index"
end
