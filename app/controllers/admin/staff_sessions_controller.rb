class Admin::StaffSessionsController < ApplicationController
	before_filter :skip_header
	def new
	end

	def create 
		staff = Staff.find_by_user_name(params[:staff_session][:user_name].downcase)
		if staff && staff.authenticate(params[:staff_session][:password])
			sign_in staff
			redirect_to '/admin'
		else
			flash.now[:error] = 'Invalid user name/password combination'
			render 'new'
		end
	end

	def destroy
    	sign_out
    	redirect_to '/admin/staffsignin'
  	end
end
