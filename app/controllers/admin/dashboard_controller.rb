class Admin::DashboardController < ApplicationController
	before_filter :signed_in_staff
	before_filter :skip_header
  def index
  end



   private 
	def correct_user
		@staff = Staff.find(params[:id])
		if !current_user_staff?(@staff)
			flash[:error] = "Wrong user"
			redirect_to('/admin/staffsignin')
		end
	end
end
