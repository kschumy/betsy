class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def login
    auth_hash = request.env['omniauth.auth']
    if auth_hash[:uid]
      @merchant = Merchant.find_by(uid: auth_hash[:uid])
      if @merchant.nil? # new Merchant
        @merchant = Merchant.build_from_github(auth_hash)
        @merchant.save ? successful_login("Welcome") : unsuccessful_login("Merchant creation error")
      else
        successful_login("Welcome back")
      end
    else
      unsuccessful_login("Logging in through GitHub not successful")
    end
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    # if @merchant.nil?
    #   if Merchant.find_by(id: params[:id])
    #     flash[:status] = :failure
    #     flash[:notice] = "Access to this page is restricted!"
    #     redirect_to merchants_path
    #   else
    #     render_404
    #   end
    # else
    #   @merchant
      # elseif
      # need to think how we will do this with session login or just have login/logout here
      #
    end

  def destroy
    session[:merchant_id] = nil
    flash[:success] = "Successfully logged out!"
    redirect_to root_path
  end

    private

    def successful_login(message)
      success_message = message << ", " << @merchant.username
      flash[:success] = success_message
      session[:merchant_id] = @merchant.id
      redirect_to root_path
    end

    def unsuccessful_login(error_message)
      flash[:error] = error_message
      redirect_to root_path
    end

    def merchant_params
      return params.require(:merchant).permit(:username, :email, :uid, :provider)
    end
  end
