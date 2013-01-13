class WattballsController < ApplicationController
    def new
	@wattball = Wattball.new
    end

    def index
	@hwattballs = Wattball.all
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
