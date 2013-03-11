class Admin::UsersController < Admin::AdminBaseController
  def index
    @users = User.order(sort_column(User) + " " + sort_direction)
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
      redirect_to admin_users_url, :notice => "Successfully created a user."
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
end
