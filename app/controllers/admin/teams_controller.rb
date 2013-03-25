class Admin::TeamsController < Admin::AdminBaseController
  def new
    @team = Team.new
    11.times { @team.wattballs.build }		
  end

  def show
    @team = Team.find(params[:id])
  end

  def index
    @teams = Team.order(sort_column(Team) + " " + sort_direction)
  end

  def edit
    @team = Team.find(params[:id])
    if DateTime.now >= Tournament.find(1).start_date
      flash[:failure] = "Tournament has started - cannot edit"
      redirect_to [:admin, @team]
    end
  end

  def update
    @team = Team.find(params[:id])
    params[:team][:user_id] = (Team.where(id: params[:id]).pluck(:user_id)).first
    if @team.update_attributes(params[:team])
      redirect_to [:admin,@team], notice: "Successfully updated a Team."
    else
      render 'edit'
    end
  end

  def create	
  @team = Team.new(params[:team])
    if @team.save
      redirect_to admin_teams_url, notice: "Team is now registred!"
    else
      render 'new'
    end
  end

  def destroy
    @team = Team.find(params[:id])
    if DateTime.now >= Tournament.find(1).start_date
      flash[:failure] = "Tournament has started - cannot delete"
      redirect_to [:admin, @team]
    else
      Team.find(params[:id]).destroy
      Match.delete_all
      redirect_to action: 'index'
    end
  end
end
