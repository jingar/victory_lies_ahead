class Admin::HurdlesController < Admin::AdminBaseController
  def new
 @hurdle = Hurdle.new
  end

  def show
    @hurdle = Hurdle.find(params[:id])
  end
  
  def index
    @hurdles = Hurdle.order(sort_column(Hurdle) + " " + sort_direction)
  end
    
  def create
    @hurdle = Hurdle.new(params[:hurdle])
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
   params[:hurdle][:user_id] = (Hurdle.where(id: params[:id]).pluck(:user_id)).first
   if @hurdle.update_attributes(params[:hurdle])
     redirect_to [:admin,@hurdle], notice: "Successfully updated a Hurdle."
   else
     render action: 'edit'
    end
 end
end
