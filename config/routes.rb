Rails.application.routes.draw do

  resources :categories, only: [:create, :edit, :show, :index, :new]
  resources :reviews, only: [:create, :show]
  resources :order_items, only: [:index]
  resources :orders, only: [:new, :create, :edit, :show, :index]
  resources :products, except: [:destroy]
  patch '/products/:id/deactivate', to: "products#deactivate", as: 'deactivate_product'
  resources :merchants, only: [:create, :show, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
