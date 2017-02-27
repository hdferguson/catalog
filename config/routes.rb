Rails.application.routes.draw do
  devise_for :accounts,  :controllers => { :registrations => 'registrations' }
  resources :orders
  get 'hello_world', to: 'hello_world#index'
  get 'search', to: 'store#search'
  mount ActionCable.server => '/cable'
  resources :line_items do
    put 'decrease', on: :member
    post 'decrease', on: :member
  end
  resources :carts
  root 'store#index', as: 'store_index'

  resources :products
  
  resources :sellers do
    resources :products

    member do
        get 'orders', to: 'line_items#show_orders_for_seller'
    end
end
  
  resources :buyers, only: [:edit, :update]
  resources :sellers, only: [:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
