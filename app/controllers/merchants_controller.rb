class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
  end

  def new
  end

  def create
    Merchant.create(merchant_params)
    redirect_to merchants_path
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
