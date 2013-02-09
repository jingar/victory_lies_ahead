class HurdlesController < ApplicationController
  #before_filter :signed_in_user
    def new
	@hurdle = Hurdle.new
    end

    def show
        @hurdle = Hurdle.find(params[:id])
    end

    def index
	@hurdles = Hurdle.all
    end
    
    def create
		@hurdle = current_user.hurdles.build(params[:hurdle])
		if @hurdle.save
		    flash[:success] = "Hurdle athlete is now registred!"
		    redirect_to @hurdle
		else
			render 'new'
		end
    end
end
