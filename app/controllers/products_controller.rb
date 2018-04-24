class ProductsController < ApplicationController

  def index
    @products = Product.products_available
  end

  def show
    product = Product.find_by(id: params[:id])

    if product == nil
      flash[:alert] = "Product does not exist"
      redirect_to products_path
    else
      @product = product
      @product_merchant = @product.merchant
    end
  end

  def new
    if @merchant.nil?
      flash[:alert] = "Must be logged in to view page"
      redirect_to products_path
    else
      @product = Product.new
    end
  end

  def create
    @product = Product.new(product_params)
    @product.discontinued = false
    @product.merchant = @merchant
    if @product.save
      flash[:success] = "#{@product.name} saved"
      redirect_to products_path
    else
      flash[:alert] = "Could not create product #{@product.name}"
      render :new
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to root_path
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    if !@product.nil?
      if @product.update(product_params)
        flash[:success] = "#{@product.name} updated"
        redirect_to product_path(@product.id)
      else
        flash[:alert] = "A problem occurred: Could not update product #{@product.name}"
        render :edit
      end
    else
      redirect_to products_path
    end
  end

  def deactivate
    @product = Product.find_by(id: params[:id])
    if !@product.nil?
      if @product.update(discontinued: true)
        flash[:success] = "Product #{@product.name} (Product ID: #{@product.id}) Deactivated"
        redirect_to merchant_path(@merchant.id)
      else
        flash[:alert] = "A problem occurred: Could not deactivate product #{@product.name}"
        redirect_to merchant_path(@merchant.id)
      end
    else
      redirect_to products_path
    end
  end

  private
  def product_params
    return params.require(:product).permit(:name, :price, :description, :stock, :photo, :discontinued, :merchant_id, category_ids: [])
  end
end
