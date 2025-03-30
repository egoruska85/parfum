Rails.application.routes.draw do

  devise_for :users
  get 'cart', to: 'cart#show'
  get 'ordercart', to: 'cart#ordercart'

  post 'cart/add'
  post 'cart/remove'
  post 'orders/add'
  post 'orders/remove'
  post 'orders/addposition'

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "main#index"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :backoffices do
    collection {get :options}
    collection {get :settings}
    collection {get :products}
    collection {get :interface}
    member {get :order}
  end
  resources :orders do
    resources :order_items, only: [:update, :create]
    member {patch :user_ordered}
    member {get :order}
  end
  resources :currencies
  resources :categories
  resources :genders
  resources :carousels
  resources :interfaceoptions
  resources :products
end
