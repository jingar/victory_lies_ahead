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

    def create
		@team = current_user.teams.build(params[:team], :without_protection => true)
		if @team.save
		    flash[:success] = "Wattball team is now registred!"
		    redirect_to @team
		else
		    render 'new'
		end
    end
end
