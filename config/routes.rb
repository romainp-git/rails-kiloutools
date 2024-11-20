Rails.application.routes.draw do
  get 'store/index'
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    resources :bookings, only: [:new, :create]

    collection do
      get :search
    end
  end

  resources :bookings, only: [:show, :index, :destroy]
  resources :profiles, only: [:show]
  resources :stores, only: [:index]
end
