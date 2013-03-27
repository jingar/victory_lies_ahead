class HurdlesController < ApplicationController
    def new
	@hurdle = Hurdle.new
    end

    def show
        @hurdle = Hurdle.find(params[:id])
    end

    def index	
	@hurdles = Hurdle.order("round DESC, gender, qualification ASC")
	@heats = Heats.all
    end
    
    def create
      @hurdle = current_user.hurdles.build(params[:hurdle])

      #if qualified skip round 0
      qual = @hurdle.qualification
      if qual.min == 0 && qual.hour == 0 && qual.sec == 0
        @hurdle.round = 0
      else
        @hurdle.round = 1
      end

      if @hurdle.save
        flash[:success] = "Hurdle athlete is now registred!"
        redirect_to @hurdle
      else
        render 'new'
      end
    end
  end
