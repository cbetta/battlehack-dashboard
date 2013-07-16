Dashboard::Application.routes.draw do
  resources :tweets

  root "dashboard#index"
end
