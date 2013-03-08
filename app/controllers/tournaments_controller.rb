class TournamentsController < ApplicationController
  include TournamentsHelper
  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      redirect_to @tournament
    else
      render 'new'
    end
  end

  def show
     @tournament = Tournament.find(params[:id])
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:success] = "Tournament details updated"
      redirect_to @tournament
    else
      render 'edit'
    end
  end

  def populate_heats
    begin
      @tournament = Tournament.find(params[:id])
      genders = ["m","f"]

      genders.each do |gen|
        #find the last played heat -> round, if none - assume round 0
        last_heat=Heat.rounded_heats.where("played=? and gender=?",true,gen).last
        round = if last_heat == nil then 0 else last_heat.round + 1 end
        #COMMENT TO DEBUG
        raise RoundNotEmpty if Heat.where("round=? and gender=?",round,gen)[0].hurdles !=[]

        #find all racers for this round, raise exception, if none
        hurdles = Hurdle.where("round = ? AND gender = ?",round,gen)
        raise NoHurdles if hurdles==[]
        heats = @tournament.heats.where("round=? AND gender = ?",round,gen)
        raise NoHeats if heats==[]

        #calculate round size
        unisex_racers = Hurdle.where("gender = ?", gen)
        no_qual = unisex_racers.where("round = ?", 0)
        rounds = find_round_sizes(unisex_racers.count, no_qual.count)

        #do nothing, if at the end of the tournament
        return tour if rounds[round]==nil

        heats=populate_round(hurdles, rounds[round], heats)
#logger.debug "oo0 lane:"+heats[0].heat_hurdles[0].hurdle_id.to_s
      end

    rescue RoundNotEmpty
      flash[:falure] = "Current round is already populated, wait for all results to be filled in."
      redirect_to @tournament
      return
    rescue NoHurdles
      flash[:falure] = "No hurdles are yet registred for this round."
      redirect_to @tournament
      return
    end

    if @tournament.save
      flash[:success] = "Tournament round is populated!"
      redirect_to @tournament
    else
      flash[:failure] = "Tournament population went wrong"
      redirect_to @tournament
    end
  end

  def generate_heats
    @tournament = Tournament.find(params[:id])

    begin
      @tournament = generate_tournament(@tournament)
    rescue TournamentNotEmpty
      flash[:failure] = "Tournament is not empty."
      redirect_to @tournament
      return
    end

    if @tournament.save
      flash[:success] = "Tournament heats are generated!"
      redirect_to @tournament
    else
      flash[:failure] = "Tournament generation went wrong"
      redirect_to @tournament
    end
  end

  def delete_heats
    @tournament = Tournament.find(params[:id])

    #destroy all heats before rescheduling
    if Heat.destroy_all(tournament_id: @tournament)
      flash[:success] = "Heats are deleted!"
      redirect_to @tournament
    else
      flash[:failure] = "Heat deletion went wrong"
      redirect_to @tournament
    end
  end
end
