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
    @tournament = Tournament.find(params[:id])

    begin
      @tournament = populate_tournament(@tournament)
    rescue "RoundNotEmptyException"
      flash[:falure] = "Round 0 has already been populated, wait for competition to commence."
      redirect_to @tournament
    rescue "NoHurdleException"
      flash[:falure] = "No hurdles are yet registred for this round."
      redirect_to @tournament
    end

    if @tournament.save!
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
    rescue "TournamentNotEmptyException"
    #rescue
      flash[:failure] = "Tournament is not empty."
      redirect_to @tournament
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
