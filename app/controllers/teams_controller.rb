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
    @matches = Match.all
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
    @team = current_user.teams.build(params[:team])
    #@team.team_name = params[:team][:team_name]
    if @team.save
      flash[:success] = "Wattball team is now registred!"
      Match.delete_all
      redirect_to @team
    else
      render 'new'
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to action: 'index'
  end
end
