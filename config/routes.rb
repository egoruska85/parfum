Rails.application.routes.draw do
  get 'cart', to: 'cart#show'
  get 'ordercart', to: 'cart#ordercart' 

  post 'cart/add'
  post 'cart/remove'


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
  end
  resources :currencies
  resources :categories
  resources :genders
  resources :carousels
  resources :interfaceoptions
  resources :products
end
