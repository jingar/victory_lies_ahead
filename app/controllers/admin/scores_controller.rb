class Admin::ScoresController < ApplicationController

  def index 
    @scores = Score.order(sort_column(Score) + " " + sort_direction)
  end 

  def new
    @score = Score.new(params[:score])
  end

  def edit
    @score = Score.find(params[:id])
  end
 
  def create
    @score = Score.new(params[:score])
    if @score.save
      flash[:success] = "Welcome to the Heriot-Watt Sports Tournament!"
      redirect_to admin_scores_path
    else
      render 'new'
    end
  end
end
