class HeatResultsController < ApplicationController
  def index
    @heat_results = HeatResult.all
  end

  def new
    @heat_result = HeatResult.new
  end

  def create
    @heat_result = Heat.new
    @heat_result.time_result = params[:heat_result][:time_result]
    @heat_result.heat_id = params[:heat_result][:heat_id]
    @heat_result.hurdle_id = params[:heat_result][:hurdle_id]
    if @heat_result.save
      redirect_to @heat_result
    else
      render 'new'
    end
  end

  def show
    @heat_result = HeatResult.find(params[:id])
  end

  def edit
    @heat_result = HeatResult.find(params[:id])
  end

  def update
    @heat_result = HeatResult.find(params[:id])
    if @heat_result.update_attributes(params[:heat_result])
      redirect_to @heat_result
    else
      render 'edit'
    end
  end

  def destroy
    @heat_result = HeatResult.find(params[:id])
    @heat_result.destroy
    redirect_to heat_results_url, :notice => "Successfully deleted a heat."
  end
end
