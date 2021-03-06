Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'threads#index'

  resources :threads, only: [:index] do
    get :go, on: :collection
    post :set, on: :collection
    get :get, on: :collection
  end
end
