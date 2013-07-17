Dashboard::Application.routes.draw do
  resources :tweets
  resource :timer do
    member do
      get "status"
    end
  end

  get '/admin', to: 'admin#index'

  root "dashboard#index"
end
