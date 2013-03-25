class Admin::HeatsController < Admin::AdminBaseController
include HeatsHelper; include TournamentsHelper
HEAT_SIZE=8
  def index
    @heats = Heat.rounded_heats
  end

  def new
    @heat = Heat.new
  end

  # Reconstruct a date object from date_select helper form params
  def build_date_from_params(field_name, params)
    Date.new(params["#{field_name.to_s}(1i)"].to_i, 
      params["#{field_name.to_s}(2i)"].to_i, 
      params["#{field_name.to_s}(3i)"].to_i)
  end

  def create
    @heat = Heat.new
    @heat.gender = params[:heat][:gender]
s    @heat.time = build_date_from_params(:time, params[:heat])
    if params[:heat][:hurdles][:hurdle_id].length == (HEAT_SIZE+1)
      params[:heat][:hurdles][:hurdle_id].each do |h|
      if h != ""
        @heat.hurdles << Hurdle.find(h)
      end
    end
      if @heat.save
        redirect_to [:admin,@heat]
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @heat = Heat.includes(:hurdles).find(params[:id])
  end

  def edit
    @heat = Heat.find(params[:id])
  end

  def update
    @heat = Heat.find(params[:id])
    if @heat.update_attributes(params[:team])
      flash[:success] = "Heat updated"
      redirect_to [:admin,@heat]
    else
      render 'edit'
    end
    if false
    #@heat.gender = params[:heat][:gender]
    #@heat.time = build_date_from_params(:time, params[:heat])

    #redundant feature of editing hurdles in the heat
    if params[:heat][:hurdles][:hurdle_id].length == (HEAT_SIZE+1)
      #delete old hurdles
      HeatHurdle.where("heat_id = ?", @heat.id).each do |h_h|
        h_h.destroy
      end

      params[:heat][:hurdles][:hurdle_id].each do |h|
      if h != ""
        @heat.hurdles << Hurdle.find(h)
      end
    end
      if @heat.save
        redirect_to [:admin,@heat]
      else
        render 'edit'
      end
    else
      render 'edit'
    end
    end#end of redundant feature
  end

  def destroy
    @heat = Heat.find(params[:id])
    Heat.delete_all
    redirect_to heats_url, :notice => "Successfully deleted a heat."
  end

  def add_result
    @heat = Heat.find(params[:id])
  end

  def update_result
    @heat = Heat.find(params[:id])
    @heat.played = true
    update_racers(@heat)
    if @heat.update_attributes(params[:heat])
      flash[:success] = "Heat details updated"

      if Heat.where("round=? and played=?",@heat.round, false).count == 0
        begin
          @tournament = Tournament.find(@heat.tournament_id)
          @tournament = populate_tournament(@tournament)
        rescue RoundNotEmpty
          flash[:falure] = "Round 0 has already been populated, wait for competition to commence."
          redirect_to [:admin,@heat]
          return
        rescue NoHurdles
          flash[:falure] = "No hurdles are yet registred for this round."
          redirect_to [:admin,@heat]
          return
        rescue NoHeats
          flash[:falure] = "No heats are yet generated."
          redirect_to [:admin,@heat]
          return
        end

        if @tournament.save
          flash[:success] = "Tournament round is populated!"
          return redirect_to [:admin,@tournament]
        else
          flash[:failure] = "Tournament population went wrong"
          return redirect_to [:admin,@tournament]
        end
      end
      # THIS LINE IS CAUSING THE ERROR-AFTER YOUR ENTER THE LAST RESULT FOR THE ROUND
      redirect_to [:admin,@heat]
    else
      render 'add_result'
      return
    end
  end
end
