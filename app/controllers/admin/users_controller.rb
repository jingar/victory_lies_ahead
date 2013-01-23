class Admin::UsersController < ApplicationController
  before_filter :signed_in_staff
  before_filter :skip_header

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to [:admin,@user], :notice => "Successfully created a user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to [:admin,@user], :notice  => "Successfully updated a user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, :notice => "Successfully deleted a user."
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
