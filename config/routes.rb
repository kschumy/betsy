Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'merchants#login'
  get '/auth/github', as: 'github_login'

  # TODO: is 'login' correct??
  # delete 'login', to: 'merchants#destroy', as: 'github_logout'
  delete "/logout", to: "merchants#destroy", as: "logout"


  root 'products#index'
  resources :categories, only: [:create, :edit, :show, :index]
  resources :reviews, only: [:create, :show]
  resources :order_items
  resources :orders, only: [:new, :create, :edit, :show, :index]
  resources :products, except: [:destroy]
  patch '/products/:id/deactivate', to: "products#deactivate", as: 'deactivate_product'
  resources :merchants #, only: [:create, :show, :index]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
