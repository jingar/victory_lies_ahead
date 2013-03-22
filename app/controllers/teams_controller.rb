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

    @teams.each do |team|
      team.wins = 0
      team.draws = 0
      team.losses = 0
      team.goalsfor = 0
      team.goalsagainst = 0
      team.points = 0
      team.goalsdif = 0
      @matches.each do |match|
        if match.homeTeam == team.id and not match.homeGoals == nil
          team.goalsfor += match.homeGoals
          team.goalsagainst += match.awayGoals
          if match.homeGoals > match.awayGoals
            team.wins += 1
          elsif match.homeGoals < match.awayGoals
            team.losses += 1
          elsif match.homeGoals == match.awayGoals
            team.draws += 1
          end

        elsif match.awayTeam == team.id and not match.awayGoals == nil
          team.goalsfor += match.awayGoals
          team.goalsagainst += match.homeGoals
          if match.homeGoals > match.awayGoals
            team.losses += 1
          elsif match.homeGoals < match.awayGoals
            team.wins += 1
          elsif match.homeGoals == match.awayGoals
            team.draws += 1
          end
        end
        team.points = (team.wins * 3 + team.draws)
        team.goalsdif = (team.goalsfor - team.goalsagainst)
        team.save
      end
    end
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
