class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def find_merchant
    @merchant = Merchant.find_by(id: session[:merchant_id])
  end
end
