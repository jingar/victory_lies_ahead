class Admin::HurdlesController < ApplicationController
  before_filter :signed_in_staff
  before_filter :skip_header
  
  def new
	@hurdle = Hurdle.new
  end

  def show
    @hurdle = Hurdle.find(params[:id])
  end

  def index
	   @hurdles = Hurdle.all
  end
    
  def create
    @hurdle = Hurdle.new
    @hurdle.first_name = params[:hurdle][:first_name]
    @hurdle.last_name = params[:hurdle][:last_name]
    @hurdle.qualification = params[:hurdle][:qualification]
    @hurdle.gender = params[:hurdle][:gender]
    @hurdle.user_id = params[:hurdle][:user_id]
    if @hurdle.save
      redirect_to admin_hurdles_url, notice: "Hurdle athlete is now registred!"
    else
      render 'new'
    end
  end
  
  def destroy
    @hurdle = Hurdle.find(params[:id])
    @hurdle.destroy
    redirect_to admin_hurdles_url, :notice => "Successfully deleted a hurdle racer"
  end

 def edit
    @hurdle = Hurdle.find(params[:id])
 end
 
 def update
   @hurdle = Hurdle.find(params[:id])
   first_name = params[:hurdle][:first_name]
   last_name = params[:hurdle][:last_name]
   qualification = params[:hurdle][:qualification]
   gender = params[:hurdle][:gender]
   user_id = (Hurdle.where(id: params[:id]).pluck(:user_id)).first
   if Hurdle.find(params[:id]).update_attributes(user_id: user_id,first_name: first_name, last_name: last_name, qualification: qualification, gender: gender)
     redirect_to [:admin,@hurdle], notice: "Successfully updated a Hurdle."
   else
     render action: 'edit'
    end
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
