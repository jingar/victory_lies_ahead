class MatchesController < ApplicationController
  include ActiveModel::MassAssignmentSecurity

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
    @teams = Team.all(:select => "team_name")
	end

  
  def show
    @match = Match.find(params[:id])
  end
end
