class Admin::TicketsController < Admin::AdminBaseController
  	def new
  	@ticket = Ticket.new
	end

	def create
		@ticket = Ticket.new(params[:ticket])
		if @ticket.save
                  TicketMailer.ticket_email(@ticket).deliver
                  flash[:success] = "You have successfully bought a ticket"
                  redirect_to admin_path
		else
			render 'new'
		end
	end
end
