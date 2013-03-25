class Admin::TournamentsController < Admin::AdminBaseController
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
      redirect_to [:admin,@tournament]
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
      redirect_to [:admin,@tournament]
    else
      render 'edit'
    end
  end

  def populate_heats
    #mylogger ||= Logger.new("#{Rails.root}/log/my.log")
    @tournament = Tournament.find(params[:id])
    begin
      @tournament = populate_tournament(@tournament)

    rescue RoundNotEmpty
      flash[:falure] = "Current round is already populated, wait for all results to be filled in."
      redirect_to [:admin,@tournament]
      redirect_to @tournament
      return
    rescue NoHurdles
      flash[:falure] = "No hurdles are yet registred for this round."
      redirect_to [:admin,@tournament]
      return
    rescue NoHeats
      flash[:falure] = "No heats are yet generated."
      redirect_to [:admin,@tournament]
      return
    end

    if @tournament.save
      flash[:success] = "Tournament round is populated!"
#mylogger.info "array 0 lane:"+@heats[0].heat_hurdles[0].lane.to_s
#mylogger.info "tournament 0 lane:"+@tournament.heats.first.heat_hurdles[0].lane.to_s
      redirect_to [:admin,@tournament]
    else
      flash[:failure] = "Tournament population went wrong."
      redirect_to [:admin,@tournament]
    end
  end

  def generate_heats
    @tournament = Tournament.find(params[:id])

    begin
      @tournament = generate_tournament(@tournament)
    rescue TournamentNotEmpty
      flash[:failure] = "Tournament is not empty."
      redirect_to [:admin,@tournament]
      return
    end

    if @tournament.save
      flash[:success] = "Tournament heats are generated!"
      redirect_to [:admin,@tournament]
    else
      flash[:failure] = "Tournament generation went wrong"
      redirect_to [:admin,@tournament]
    end
  end

  def delete_heats
    @tournament = Tournament.find(params[:id])

    #destroy all heats before rescheduling
    if Heat.destroy_all(tournament_id: @tournament)
      flash[:success] = "Heats are deleted!"
      redirect_to [:admin,@tournament]
    else
      flash[:failure] = "Heat deletion went wrong"
      redirect_to [:admin,@tournament]
    end
  end

  def set_results
    @tournament = Tournament.find(params[:id])
    @tournament = set_heat_results(@tournament)

    if @tournament.save
      flash[:success] = "Results are added!"
      redirect_to [:admin,@tournament]
    else
      flash[:failure] = "Results addition went wrong"
      redirect_to [:admin,@tournament]
    end
  end
end
