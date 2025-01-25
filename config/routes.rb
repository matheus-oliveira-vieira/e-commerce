Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      get "/current_user", to: "users#current"
      get "/get_cart_id", to: "carts#get_cart_id"
      post "/new_cart", to: "carts#create", as: :new_cart
      post "/add_to_cart/:product_id", to: "carts#add_to_cart", as: :add_to_cart
      patch "/update_quantity/:product_id", to: "carts#update_quantity", as: :update_quantity
      patch "/downgrade_quantity/:product_id", to: "carts#downgrade_quantity", as: :downgrade_quantity
      delete "/remove_product_from_cart/:product_id", to: "carts#remove_product_from_cart", as: :remove_product_from_cart
      resources :carts, only: %i[show] do
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
