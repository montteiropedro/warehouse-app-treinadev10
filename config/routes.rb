Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users

  root 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :stock_product_destinations, only: [:create]
  end
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create]
  resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
    resources :order_items, only: [:new, :create]
    get 'search', on: :collection
    member do
      post 'delivered'
      post 'canceled'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:index, :show, :create]
    end
  end
end
