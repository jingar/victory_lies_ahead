class StaffSessionsController < ApplicationController
	def new
	end

	def create 
		staff = Staff.find_by_user_name(params[:session][:user_name].downcase)
		if staff && staff.authenticate(params[:session][:password])
			sign_in staff
			redirect_back_or staff
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
    	staff_sign_out
    	redirect_to root_url
  	end
end
