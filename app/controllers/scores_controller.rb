class ScoresController < ApplicationController

  def show
    @wattball = Wattball.find(params[:id])
  end

  def index
    @wattballs = Wattball.all
    @top = Wattball.find(:all, :order => "goals desc, last_name asc").take(20)
  end
end
