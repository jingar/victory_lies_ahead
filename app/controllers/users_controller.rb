class UsersController < ApplicationController
  before_filter :signed_in_user, only:[:edit,:update,:show]
  before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

	def show
	    @user = User.find(params[:id])
  	end
  	
  	def new
  		if DateTime.now >= Tournament.find(1).start_date
      		flash[:failure] = "Tournament has started - cannot delete"
      		redirect_to root_path
    	else
  			@user = User.new
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Heriot-Watt Sports Tournament!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def index
		@users = User.all
	end

	def edit
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end
	
	private
        def correct_user
          @user = User.find(params[:id])
          if !current_user?(@user)
            flash[:notice] = "Incorrect user."
          redirect_to(root_path)
          end
        end
end
