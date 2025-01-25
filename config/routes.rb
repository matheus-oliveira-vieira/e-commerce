Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      get "/current_user", to: "users#current"
      resources :carts do
        get "/new_cart", to: "carts#new"
        post "/add_to_cart/:product_id", to: "carts#add_to_cart"
        patch "/update_quantity/:product_id", to: "carts#update_quantity"
        patch "/downgrade_quantity/:product_id", to: "carts#downgrade_quantity"
        delete "/remove_product_from_cart/:product_id", to: "carts#remove_product_from_cart"
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
