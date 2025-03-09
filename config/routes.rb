Rails.application.routes.draw do
  get 'main/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "main#index"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :backoffices do
    collection {get :options}
    collection {get :settings}
  end

  resources :categories
  resources :genders
end
