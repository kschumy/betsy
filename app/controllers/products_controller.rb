class ProductsController < ApplicationController

  def index
    @products = Product.products_available
    @categories = Category.order(:name)
    if params[:merchant_id]
      @products = Product.includes(:merchant).where(products: {merchant_id: params[:merchant_id]})
    elsif params[:category_id]
      @products = Product.includes(:categories).where( categories: { id: params[:category_id]})
    else
      @products = Product.order(:id)
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    @order_item = OrderItem.new
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
      render_404
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
      flash.now[:alert] = @product.errors
      render :new
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render_404 unless !@merchant.nil? && @merchant.id == @product.merchant.id

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
    return params.require(:product).permit(:name, :price, :description, :stock, :photo, :discontinued, :price_from_form, :merchant_id, category_ids: [])
  end
end
