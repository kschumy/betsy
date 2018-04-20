class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    product = Product.find_by(id: params[:id])
    if product == nil
      flash[:alert] = "Product does not exist"
      redirect_to products_path
    else
      @product = product
    end
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
end
