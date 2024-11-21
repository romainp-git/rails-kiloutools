Rails.application.routes.draw do
  get 'store/index'
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    resources :bookings, only: [:create]

    collection do
      get :search
    end

    member do
      patch 'update_active'
      patch 'add_photos'
      delete 'destroy_photo'
    end

  end

  resources :bookings, only: [:show, :index, :destroy, :update]
  resources :profiles, only: [:show, :update]
  resources :stores, only: [:index]
  get 'stores/ads', to: 'products#summary', as: 'product_summary'
end
