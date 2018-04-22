Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/github', as: 'github_login'

  get '/login', to: 'sessions#new', as: 'login_form'
  post '/login', to: 'sessions#create', as: 'login'
  delete '/login', to: 'sessions#destroy', as: 'logout'
  root 'products#index'
  resources :categories, only: [:create, :edit, :show, :index]
  resources :reviews, only: [:create, :show]
  resources :order_items
  patch 'order_items/:id/mark_shipped', to: 'order_items#mark_shipped', as: 'mark_item_shipped'
  resources :orders, only: [:new, :create, :edit, :update, :show, :index]
  resources :products, except: [:destroy]
  patch '/products/:id/deactivate', to: "products#deactivate", as: 'deactivate_product'
  resources :merchants, only: [:create, :show, :index]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
