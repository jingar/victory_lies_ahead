class Admin:: WattballsController < Admin::AdminBaseController
  def new
    @wattball = Wattball.new 
  end

  def show
    @wattball = Wattball.find(params[:id])
  end

  def index
    @wattballs = Wattball.order(sort_column(Wattball) + " " + sort_direction)
  end

  def create	
    @wattball = Wattball.find_by_team_id(Team.find(params[:wattball][:team_id])).build
     redirect_to admin_wattballs_url, notice: @wattball.inspect
    #team_id = Team.find(params[:wattball][:team_id])
    #@wattball = Wattball.build_from(team_id,params[:wattball])
    @wattball.first_name = params[:wattball][:first_name]
    @wattball.last_name = params[:wattball][:last_name]
    if @wattball.update_attributes(params[:wattball])
      redirect_to admin_wattballs_url, notice: @wattball.inspect
    else
     # render 'new'
    end
  end

  def destroy
    @wattball = Wattball.find(params[:id])
    @wattball.destroy
    redirect_to admin_wattballs_url, :notice => "Successfully deleted a wattball racer"
  end

end
