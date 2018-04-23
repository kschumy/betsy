class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order  = Order.new(order_params)
    #note: I'm not sure which is more suitable, the above or Order.create(order_params)
    if @order.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created order"
      redirect_to order_items_path
    else
      flash[:status] = :failure
      flash[:result_text] = "Order did not create"
      flash[:messages] = @order.errors.messages
      render :new
      # raise
    end

  end

  def edit
    @order = Order.find_by(id: params[:id])
    if @order.nil?
      redirect_to products_path
    end
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.update(order_params)
    if @order.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated order"
      # redirect_to order_items_path
      redirect_to order_path(params[:id])
    else
      flash[:status] = :failure
      flash[:result_text] = "Order did not update"
      flash[:messages] = @order.errors.messages
      render :edit

      # redirect_to order_path(params[:id])
    end
  end

  def view_cart
    @order = Order.find_by(id: params[:id])
  end

  # def view_cart
  # end

  def destroy
  end

  private
  def order_params
    return params.require(:order). permit(:email_address, :cc_name, :email_address, :cc_number, :cc_exp_month, :cc_exp_year , :cc_cvv, :cc_zip, :status, :street , :customer_name ,:city, :state, :mailing_zip )
  end

end
