class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.all
  end

  def show
    @order_item = OrderItem.find_by(id: params[:id])
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item  = OrderItem.new(order_item_params)
    if !session.has_key?(:cart_id)
      @order = Order.create(status: "pending")
      session[:cart_id] = @order.id
    else
      # @order = Order.new(status: "pending")
      # session[:cart_id] = @order.id
      @order = Order.find_by(id: session[:cart_id])
    end
    @order.add_item_to_cart(@order_item)
    
    if @order_item.save
      flash[:success] = :success
      # flash[:result_text] = "Successfully added item ##{@order_item.id} to shopping cart"
      redirect_to order_items_path
    else
      # flash[:status] = :failure
      # flash[:result_text] = "Item did not add to shopping cart"
      flash[:alert] = @order_item.errors.messages

      # render :new
    end

  end

  def edit
    @order_item  = OrderItem.find_by(id: params[:id])
  end

  def update
    @order_item  = OrderItem.find_by(id: params[:id])
    @order_item.update(order_item_params)
    redirect_to order_items_path
  end

  def destroy
    @order_item  = OrderItem.find_by(id: params[:id])
    if @order_item
      @order_item.destroy
      flash[:status] = :success
      flash[:result_text] = "Successfully destroyed item from shopping cart"
      #will personalize message
      redirect_to order_items_path
      # if it's the last thing in the order, will need to redirect to root_path?
    end
  end

  def mark_shipped
    @order_item  = OrderItem.find_by(id: params[:id])
    @order_item.update(is_shipped: true)
    @order_item.save
    redirect_to order_items_path
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :price, :is_shipped, :product_id, :order_id)
  end
end
