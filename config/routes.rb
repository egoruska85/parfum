Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  get 'users/update'

  devise_for :users
  resources :users do
    collection {get :orders}
  end
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
    collection {get :delivery_operator}
    member {get :delivery_more_detail}
    member {get :order}
    collection {get :users}
    member {get :user}
  end
  resources :orders do
    resources :order_items, only: [:update, :create]
    member {patch :user_ordered}
    member {patch :admin_ordered}
    member {patch :update_status_delivery}
    member {patch :update_pay_delivery}
    member {get :order}
    member {get :access}
    member {patch :verify}
  end
  resources :currencies
  resources :categories
  resources :genders
  resources :carousels
  resources :interfaceoptions
  resources :products
end
