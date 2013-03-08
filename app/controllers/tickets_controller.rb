class TicketsController < ApplicationController
  	def new
  	@ticket = Ticket.new
	end

	def create
		@ticket = Ticket.new(params[:ticket])
		if @ticket.save
        	TicketMailer.ticket_email(@ticket).deliver
        	flash[:success] = "You have successfully reserved ticket(s), email confirmation has been sent to " + @ticket.email
        	redirect_to root_path
		else
			render 'new'
		end
	end
end
