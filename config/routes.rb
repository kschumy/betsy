Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'merchants#create'
  get '/auth/github', as: 'github_login'

  get '/login', to: 'sessions#new', as: 'login_form'
  post '/login', to: 'sessions#create', as: 'login'
  delete '/login', to: 'sessions#destroy', as: 'logout'

  root 'products#welcome'
  resources :categories, only: [:create, :edit, :show, :index]
  resources :reviews, only: [:create, :show]
  resources :order_items
  resources :orders, only: [:new, :create, :edit, :show, :index]
  resources :products, except: [:destroy]
  patch '/products/:id/deactivate', to: "products#deactivate", as: 'deactivate_product'
  resources :merchants, only: [:create, :show, :index]



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
