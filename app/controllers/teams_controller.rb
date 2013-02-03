class TeamsController < ApplicationController
  def new
    @team = Team.new
    11.times { @team.wattballs.build }		
  end

  def show
    @team = Team.find(params[:id])
  end

  def index
    @teams = Team.all
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:success] = "Team updated"
      redirect_to @team
    else
      render 'edit'
    end
  end

  def create	
    @team = current_user.teams.first.build
    @team.team_name = params[:team][:team_name]
    if @team.save
      flash[:success] = "Wattball team is now registred!"
      redirect_to @team
    else
      render 'new'
    end
  end
end
