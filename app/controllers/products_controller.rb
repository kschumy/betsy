class ProductsController < ApplicationController
  def index
    @pcategories = Category.order(:name)
  end

  def show
  end

  def new
    @product = Product.new(product_params)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def product_params
    return params.require(:product).permit(:name, :price, :description, :stock, :photo, :discontinued)
end
