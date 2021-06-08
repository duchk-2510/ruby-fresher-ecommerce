require 'sidekiq/web'

Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, path: "", path_names: {
    sign_in: "/login",
    sign_out: "/logout",
    password: "secret",
    confirmation: "verification",
    registration: "register"
  }
  resources :users, except: :new do
    get "activate", to: "users#activate_user" , on: :collection
  end
  delete "/logout", to: "sessions#destroy"
  post "/add_to_cart", to: "carts#add_to_cart"
  scope "/checkout" do
    get "/cart", to: "carts#show"
    get "/shipping", to: "delivery_addresses#show"
    post "/shipping", to: "delivery_addresses#save_choice"
    get "/confirmation", to: "orders#new"
  end
  resources :products, except: :index
  resources :delivery_addresses, only: :create
  resources :orders, except: :new do
    member do
      post "cancel", to: "orders#cancel"
    end
  end

  namespace :admin do
    resources :orders, only: :index
    post "/order_forward", to: "orders#forward"
    post "/order_backward", to: "orders#backward"
    post "/order_reject", to: "orders#reject"
    post "/order_restore", to: "orders#restore_rejected_order"
  end

  resources :categories do
    resources :products, only: :index do
      collection do
        get "/other", to: "products#other_in_category"
        get "/search", to: "products#search"
      end
    end
  end
  mount Sidekiq::Web, at: "/sidekiq"
end
