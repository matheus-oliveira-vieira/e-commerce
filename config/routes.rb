Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      get "/current_user", to: "users#current"

      resource :cart, only: [:show] do
        resources :cart_items, only: [:create, :update, :destroy]
      end

      # resources :carts do
      #   member do
      #     get "/new_cart", to: "carts#new", as: :new_cart
      #     match '/add_to_cart/:product_id', action: :add_to_cart, via: [:get, :post], as: :add_to_cart
      #     match '/remove_product_from_cart/:product_id', action: :remove_product_from_cart, via: [:get, :delete], as: :remove_product_from_cart
      #   end
      # end

      # post "/add_to_cart/:product_id", to: "carts#add_to_cart", as: :add_to_cart
      # patch "/update_quantity/:product_id", to: "carts#update_quantity", as: :update_quantity
      # patch "/downgrade_quantity/:product_id", to: "carts#downgrade_quantity", as: :downgrade_quantity
      # delete "/remove_product_from_cart/:product_id", to: "carts#remove_product_from_cart", as: :remove_product_from_cart
      # get "/carts/:product_id", to: "carts#show"
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
