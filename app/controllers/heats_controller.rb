class HeatsController < ApplicationController
HEAT_SIZE=3
  def index
    @heats = Heat.all
  end

  def new
    @heat = Heat.new
  end

  def create
    @heat = Heat.new
    @heat.gender = params[:heat][:gender]
    @heat.time = params[:heat][:time]
    if params[:heat][:hurdles][:hurdle_id].length == (HEAT_SIZE+1)
      params[:heat][:hurdles][:hurdle_id].each do |h|
      if h != ""
        @heat.hurdles << Hurdle.find(h)
      end
    end
      if @heat.save
        redirect_to @heat
      else
        render 'edit'
      end
    else
      render 'edit'
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
    @heat.gender = params[:heat][:gender]
    @heat.time = params[:heat][:time]
    if params[:heat][:hurdles][:hurdle_id].length == (HEAT_SIZE+1)
      @heat.hurdles.clear
      params[:heat][:hurdles][:hurdle_id].each do |h|
      if h != ""
        @heat.hurdles << Hurdle.find(h)
      end
    end
      if @heat.save
        redirect_to @heat
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @heat = Heat.find(params[:id])
    @heat.destroy
    redirect_to heats_url, :notice => "Successfully deleted a heat."
  end
end
