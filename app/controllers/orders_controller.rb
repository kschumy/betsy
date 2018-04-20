class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def new
  end

  def create
    Order.create(order_params)
    redirect_to orders_path
  end

  def edit
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      redirect_to products_path
  end

  def update
    @order = Order.find_by(id: params[:id])
    order.update(order_params)
    redirect_to order_path(params[:id])
  end

  def destroy
  end

  private
  def order_params
    return params.require(:order). permit(:cc_name, :mailing_address, :email_address, :cc_number, :cc_exp, :cc_cvv, :cc_zip)
end
