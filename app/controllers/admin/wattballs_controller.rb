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
    if Team.find(@wattball.team_id).number_of_players <= 11
      redirect_to admin_wattballs_url, :notice => "Cannot delete Player, 11 players minimum per team"
    else
      @wattball.destroy
      redirect_to admin_wattballs_url, :notice => "Successfully deleted a wattball Player"
    end
  end
end
