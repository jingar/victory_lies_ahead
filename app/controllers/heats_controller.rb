class HeatsController < ApplicationController
HEAT_SIZE=8
  def index
    @heats = Heat.all
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
    @heat.time = build_date_from_params(:time, params[:heat])
    if params[:heat][:hurdles][:hurdle_id].length == (HEAT_SIZE+1)
      params[:heat][:hurdles][:hurdle_id].each do |h|
      if h != ""
        @heat.hurdles << Hurdle.find(h)
      end
    end
      if @heat.save
        redirect_to @heat
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
      redirect_to @heat
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
        redirect_to @heat
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
    @heat.destroy
    redirect_to heats_url, :notice => "Successfully deleted a heat."
  end

  def add_result
    @heat = Heat.find(params[:id])
  end

  def update_result
    @heat = Heat.find(params[:id])
    @heat.played = true
    if @heat.update_attributes(params[:heat])
      flash[:success] = "Heat details updated"
      redirect_to @heat
    else
      render 'add_result'
    end
  end
end
