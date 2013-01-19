class UmpiresController < ApplicationController
    def new
	@umpire = Umpire.new
    end

    def show
	@umpire = Umpire.find(params[:id])
    end

    def index
	@umpires = Umpire.all
    end

    def create
	@umpire = Umpire.new(params[:umpire])
	if @umpire.save
	    flash[:success] = "Umpire record is saved!"
	    redirect_to @umpire
	else
	    render 'new'
	end
    end

    def edit
    end
    
    def update
	@umpire = Umpire.find(params[:id])
	if @umpire.update_attributes(params[:umpire])
	    flash[:success] = "Umpire record updated!"
	    redirect_to @umpire
	else
	    render 'edit'
	end
    end
end
