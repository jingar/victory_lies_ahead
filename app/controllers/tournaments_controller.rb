class TournamentsController < ApplicationController
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

  def schedule_heats
    @tournament = Tournament.find(params[:id])

    #create heats for the first day - no qualifications
    gen = "m"; date = @tournament.start_date; heat_full = 0; hurdles_for_heat = []
    #find all male racers with no qualification
    Hurdle.where("qualification IS NULL AND gender = ?", gen).each do |qual|
      hurdles_for_heat << qual
      heat_full=heat_full+1
      if heat_full==8
        @tournament.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
        hurdles_for_heat = []
        heat_full = 0
      end
    end
    if heat_full != 0
      @tournament.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
      hurdles_for_heat = []; heat_full = 0
    end

    gen = "f";
    #find all female hurdles with no qualification
    Hurdle.where("qualification IS NULL AND gender = ?", gen).each do |qual|
      hurdles_for_heat << qual
      heat_full=heat_full+1
      if heat_full==8
        @tournament.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
        hurdles_for_heat = []
        heat_full = 0
      end
    end
    if heat_full != 0
      @tournament.heats.build(time: date, gender: gen).hurdles << hurdles_for_heat
      hurdles_for_heat = []; heat_full=0
    end

    if @tournament.save
      flash[:success] = "Tournament is ready to go!"
      redirect_to @tournament
    else
      flash[:failure] = "Tournament went wrong"
      redirect_to @tournament
    end
  end
end
