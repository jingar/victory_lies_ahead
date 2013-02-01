class HeatsController < ApplicationController
  def index
    @heats = Heat.all
  end

  def new
    @heat = Heat.new
  end

  def create
    @heat = Heat.new(params[:heat])
    if @heat.save
      redirect_to @heats
    else
      render 'new'
    end
  end

  def show
    @heat = Heat.find(params[:id])
  end

  def edit
  end

  def update
    @heat.find(params[:id])
    if @heat.update_attributes(params[:heat])
      redirect_to @heats
    else
      render 'edit'
    end
  end
end
