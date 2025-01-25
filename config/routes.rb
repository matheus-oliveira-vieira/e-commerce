Rails.application.routes.draw do
  devise_for :users
  root "homepage#index"
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      get "/current_user", to: "users#current"

      get "carts/:id", to: "carts#show"
      delete "carts/:id", to: "carts#destroy"

      post "line_items", to: "line_items#create"
      post "line_items/:id/add", to: "line_items#add_quantity"
      post "line_items/:id/reduce", to: "line_items#reduce_quantity"
      delete "line_items/:id", to: "line_items#destroy"

      resources :orders
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
