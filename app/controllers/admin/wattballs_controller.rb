class Admin:: WattballsController < Admin::AdminBaseController
  def new
 #   team = Team.find(params[:team_id])
#    @wattball = team.wattballs.build
    @team = Team.find(params[:team_id])
    @wattball = @team.wattballs.build
  end

  def show
    @wattball = Wattball.find(params[:id])
  end

  def index
    @wattballs = Wattball.order(sort_column(Wattball) + " " + sort_direction)
  end

  def create	
   # @wattball = Wattball.find_by_team_id(Team.find(params[:wattball][:team_id]))
#    @team = Team.find(params[:wattball][:team_id])    
 #   @wattball = @team.wattballs.build(params[:wattball])
    # @wattball = Wattball.new(params[:wattball])
    #team = Team.find(params[:wattball][:team_id])
    # user = User.find(5)
  #  @wattball = user.teams.wattballs.build(params[:wattball])
    # redirect_to admin_wattballs_url, notice: @wattball.inspect
   # @wattball = Team.find(params[:wattball][:team_id]).wattballs.build
    # @wattball = Wattball.new(params[:watball])
    #redirect_to admin_wattballs_url, notice: @wattball.
    
    
    @wattball.first_name = params[:wattball][:first_name]
    @wattball.last_name = params[:wattball][:last_name]
    #  @watball.team_id = params[:wattball][:team_id]
    if @wattball.save
      redirect_to admin_wattballs_url, notice: @wattball.inspect
    else
      render 'new'
    end
  end

  def destroy
    @wattball = Wattball.find(params[:id])
      if @wattball.destroy
        redirect_to admin_wattballs_url, :notice => "Successfully deleted a wattball Player"
      else 
        redirect_to admin_wattballs_url, :alert => "Cannot Delete Player , 11 players minmum per team"
      end
  end
end
