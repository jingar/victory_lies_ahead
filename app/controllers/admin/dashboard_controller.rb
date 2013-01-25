class Admin::DashboardController < ApplicationController
	before_filter :signed_in_staff
	before_filter :skip_header
  def index
  end



   private 
	def signed_in_staff
		    unless signed_in_staff?
			store_location_staff
			redirect_to '/admin/staffsignin', notice: "Please sign in."
		    end
		end

	def correct_user
		@staff = Staff.find(params[:id])
		if !current_user_staff?(@staff)
			flash[:error] = "Wrong user"
			redirect_to('/admin/staffsignin')
		end
	end
end
