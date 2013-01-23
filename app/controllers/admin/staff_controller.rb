class Admin::StaffController < ApplicationController
    before_filter :signed_in_staff
    before_filter :correct_user, only: [:new, :delete, :index]

    def show
		@staff = Staff.find(params[:id])
    end

    def new
		@staff = Staff.new
    end

    def create
		@staff = Staff.new(params[:staff])
		if @staff.save
		    sign_in @staff
		    flash[:success] = "Welcome to Staff Control Panel!"
		    redirect_to @staff
		else
		    render 'staff'
		end
    end

    def index
		@staff = Staff.all
    end

    def edit
    end

    def update
		@staff = Staff.find(params[:id])
		if @staff.update.attributes(params[:staff])
		    flash[:success] = "Staff information updated"
		    sign_in @staff
		    redirect_to @staff
		else
		    render 'edit'
		end
    end

    def delete
		Staff.find_by_user_name(params[:user_name]).destroy
		redirect_to '/admin/staffsignin'
    end

   private 
	def signed_in_staff
		    unless signed_in_staff?
			store_location_staff
			redirect_to_staff '/admin/staffsignin', notice: "Please sign in."
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
