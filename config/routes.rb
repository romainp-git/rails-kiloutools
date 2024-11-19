Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: [:index, :show] do
    collection do
      get :search
    end
  end
end
