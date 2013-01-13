class WattballsController < ApplicationController
    def new
    	 @wattball = Wattball.new 
    end

    def show
        @wattball = Wattball.find(params[:id])
    end

    def index
		@wattballs = Wattball.all
    end

    def create	
		@wattball = current_user.wattballs.build(params[:wattball])
		if @wattball.save
		    flash[:success] = "Wattball team is now registred!"
		    redirect_to @current_user
		else
		    render 'new'
		end
    end
end
