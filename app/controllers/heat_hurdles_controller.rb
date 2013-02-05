class HeatHurdlesController < ApplicationController
  def new
    @heat_hurdle = HeatHurdle.new
  def end

  def create
    @heat = Heat.find(params[:heat_hurdle][:heat_id])
    @heat_hurdle = heat.hurdles.build(params[:heat_hurdle])
    #@heat_hurdle.hurdle_id = params[:wattball][:hurdle_id]
    #if @wheat_hurdle.save
      #flash[:success] = "Wattball player is now registred!"
      #redirect_to @heat
    #else
      #render 'new'
    #end
  end
end
