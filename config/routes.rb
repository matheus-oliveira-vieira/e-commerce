Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      resources :orders, only: %i[index create]
      get "/current_user", to: "users#current"

      resource :cart, only: %i[ show ] do
        resources :cart_items, only: %i[ create update destroy ]
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
