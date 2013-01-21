class StaffSessionsController < ApplicationController
	def new
	end

	def create 
		staff = Staff.find_by_user_name(params[:staff_session][:user_name].downcase)
		if staff && staff.authenticate(params[:staff_session][:password])
			sign_in staff
			redirect_back_or staff
		else
			flash.now[:error] = 'Invalid user name/password combination'
			render 'new'
		end
	end

	def destroy
    	staff_sign_out
    	redirect_to root_url
  	end
end
