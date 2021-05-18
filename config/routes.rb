Rails.application.routes.draw do
  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/add_to_cart", to: "carts#add_to_cart"
  scope "/checkout" do
    get "/cart", to: "carts#show"
    get "/shipping", to: "delivery_addresses#show"
    post "/shipping", to: "delivery_addresses#save_choice"
    get "/confirmation", to: "orders#new"
  end
  resources :products
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
end
