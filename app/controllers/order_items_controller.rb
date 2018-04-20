class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItems.all
  end

  def show
  end

  def new
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
  def order_items_params
    params.require(:order_item).permit(:quantity)
  end
end
