class HurdlesController < ApplicationController
    def new
		@hurdle = Hurdle.new
    end
    def index
    end
    
    def create
		@hurdle = current_user.hurdles.build(params[:hurdle])
		if @hurdle.save
		    flash[:success] = "Hurdle athlete is now registred!"
		    redirect_to @current_user
		else
			render 'new'
		end
    end
end
