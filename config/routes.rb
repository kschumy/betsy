Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'merchants#login'
  get '/auth/github', as: 'github_login'

  delete "/logout", to: "merchants#destroy", as: "logout"

  root 'products#welcome'
  resources :categories, only: [:create, :edit, :show, :index, :new] do
    resources :products, only: [:index]
  end
  resources :reviews, only: [:create, :new]
  resources :order_items
  patch 'order_items/:id/mark_shipped', to: 'order_items#mark_shipped', as: 'mark_item_shipped'
  resources :orders, only: [:new, :create, :edit, :show, :index]
  resources :products, except: [:destroy] do
    resources :reviews, only: [:create, :new]
  end
  patch '/products/:id/deactivate', to: "products#deactivate", as: 'deactivate_product'
  resources :merchants #, only: [:create, :show, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
