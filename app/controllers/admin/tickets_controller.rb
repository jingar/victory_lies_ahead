class Admin::TicketsController < Admin::AdminBaseController
  	def new
  	@ticket = Ticket.new
	end

        def index
          @tickets = Ticket.order(sort_column(Ticket) + " " + sort_direction)
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

        def destroy
          @ticekt = Ticket.find(params[:id])
          @ticket.destroy 
          redirect_to admin_tickets_url, :notice => "Successfully deleted a ticket."
        end
end
