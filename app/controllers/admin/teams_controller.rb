class Admin::TeamsController < ApplicationController
  before_filter :signed_in_staff
  before_filter :skip_header
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
  @team = Team.new(params[:team])
    if @team.save
      redirect_to admin_teams_url, notice: "Team is now registred!"
    else
      render 'new'
    end

  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to action: 'index'
  end
end
