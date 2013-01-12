class HurdlesController < ApplicationController
    def new
	@hurdle = Hurdle.new
    end
    
    def create
	@hurdle = Hurdle.new(params[:hurdle])
	if @hurdle.save
	    flash[:success] = "Hurdle athlete is now registred!"
	    redirect_to 'users/show'
	end
    end
end
