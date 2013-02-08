class HeatHurdlesController < ApplicationController
  def new
    @h_h = HeatHurdle.new
  end

  def create
    @h_h = HeatHurdle.new(params[:heat_hurdle])
    if @h_h.save
      redirect_to @h_h
    else
      render 'new'
    end
  end

  def edit
    @h_h = HeatHurdle.find(params[:id])
  end

  def update
    @h_h = HeatHurdle.find(params[:id])
    if @user.update_attributes(params[:heat_hurdle])
      redirect_to @h_h
    else
      render 'edit'
    end
  end

  def destroy
    @h_h = HeatHurdle.find(params[:id])
    @h_h.destroy
    redirect_to heat_hurdles_url, :notice => "Successfully deleted a heat result."
  end
end
