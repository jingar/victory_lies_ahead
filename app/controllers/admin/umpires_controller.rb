class Admin::UmpiresController < Admin::AdminBaseController
  def new
    @umpire = Umpire.new	
  end

  def show
    @umpire = Umpire.find(params[:id])
  end

  def index
    @umpires = Umpire.order(sort_column(Umpire) + " " + sort_direction)
  end

  def edit
    @umpire = Umpire.find(params[:id])
  end

  def update
    @umpire = Umpire.find(params[:id])
    if @umpire.update_attributes(params[:umpire])
      redirect_to [:admin,@umpire], :notice  => "Successfully updated umpire details"
    else
      render :action => 'edit'
    end
  end 

  def create	
  @umpire = Umpire.new(params[:umpire])
    if @umpire.save
      redirect_to admin_umpire_url, notice: "Umpire is now registred!"
    else
      render 'new'
    end
  end
end