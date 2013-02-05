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
    @user = User.find(params[:hurdle][:user_id])
    @hurdle = Hurdle.new
    @hurdle.first_name = params[:hurdle][:first_name]
    @hurdle.last_name = params[:hurdle][:last_name]
    @hurdle.qualification = params[:hurdle][:qualification]
    @hurdle.gender = params[:hurdle][:gender]
    @hurdle.user_id = params[:hurdle][:user_id]
    #@hurdle = @user.hurdles.build(params[:hurdle])
    if @hurdle.save
      redirect_to admin_hurdles_url, notice: "Hurdle athlete is now registred!"
    else
      render 'new'
    end
    end
  end

 #def edit
   # @hurdle = Hurdle.find(params[:id])
 #end

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