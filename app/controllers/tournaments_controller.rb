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

  def schedule_round_of_heats
    @tournament = Tournament.find(params[:id])

    @tournament = schedule_tournament_heats(@tournament)

    if @tournament.save
      flash[:success] = "Tournament is ready to go!"
      redirect_to @tournament
    else
      flash[:failure] = "Tournament went wrong"
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
