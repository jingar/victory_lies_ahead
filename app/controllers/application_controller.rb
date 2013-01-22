class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

	def signed_in_staff
	    unless signed_in?(Staff)
		store_location
		redirect_to '/admin/staffsignin', notice: "Please sign in."
	    end
	end

	def correct_user
		@staff = Staff.find(params[:id])
		if !current_user?(@staff,Staff)
			flash[:error] = "Wrong user"
			redirect_to('/admin/staffsignin')
		end
	end
end
