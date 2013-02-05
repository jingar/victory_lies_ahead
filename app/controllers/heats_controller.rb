class HeatsController < ApplicationController
  def index
    @heats = Heat.all
  end

  def new
    @heat = Heat.new
    8.times { @heat.hurdles.build }		
  end

  def create
    @heat = Heat.new
    @heat.time = params[:heat][:time]
    @heat.gender = params[:heat][:gender]
    if @heat.save
      redirect_to @heat
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
    if @heat.update_attributes(params[:heat])
      redirect_to @heat
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
