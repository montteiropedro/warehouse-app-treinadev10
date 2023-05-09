Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users

  root 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
  resources :product_models, only: [:index, :show, :new, :create]
  resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
    get 'search', on: :collection
    member do
      post 'delivered'
      post 'canceled'
    end
  end
end
