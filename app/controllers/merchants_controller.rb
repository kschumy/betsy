class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    if @merchant.nil?
      if Merchant.find_by(id: params[:id])
        flash[:status] = :failure
        flash[:notice] = "Access to this page is restricted!"
        redirect_to merchants_path
      else
        render_404
      end

    elseif 
    # need to think how we will do this with session login or just have login/logout here

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
  def merchant_params
    return params.require(:merchant).permit(:username, :email, :uid, :provider)
end
