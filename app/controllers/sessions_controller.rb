class SessionsController < ApplicationController

	# def create
	# 	auth_hash = request.env['omniauth.auth']
	# 	if auth_hash[:uid]
	# 		@merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')
	# 		if @merchant.nil?
	# 			@merchant = Merchant.build_from_github(auth_hash)
	# 			if @merchant.save
	# 				flash[:success] = "Logged in successfully"
	# 				session[:merchant_id] = @merchant.id
	# 				redirect_to root_path
	# 				# successful_login
	# 			else
	# 				flash[:error] = "Some error happened in Merchant creation"
	# 				redirect_to root_path
	# 			end
	# 		else
	# 			flash[:success] = "Logged in successfully"
	# 			session[:merchant_id] = @merchant.id
	# 			redirect_to root_path
	# 			# successful_login
	# 		end
	# 	else
	# 		flash[:error] = "Logging in through GitHub not successful"
	# 		redirect_to root_path
	# 	end
	# end
	#
	# private
	#
	# def successful_login
	# 	flash[:success] = "Logged in successfully"
	# 	session[:merchant_id] = @merchant.id
	# 	redirect_to root_path
	# end

end