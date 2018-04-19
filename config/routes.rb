Rails.application.routes.draw do
  get 'products/index'

  get 'products/show'

  get 'products/new'

  get 'products/create'

  get 'products/edit'

  get 'products/update'

  get 'products/destroy'

  get 'merchants/index'

  get 'merchants/show'

  get 'merchants/new'

  get 'merchants/create'

  get 'merchants/edit'

  get 'merchants/update'

  get 'merchants/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
