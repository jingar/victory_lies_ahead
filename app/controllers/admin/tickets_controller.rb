class Admin::TicketsController < Admin::AdminBaseController
  def new
    @ticket = Ticket.new
  end
  
  def index
        @tickets = Ticket.search(params[:search])
  end

	def create
          @ticket = Ticket.new(params[:ticket])
          if @ticket.save
            TicketMailer.ticket_email(@ticket).deliver
            flash[:success] = "You have successfully reserved a ticket"
            redirect_to admin_tickets_path
          else
            render 'new'
          end
	end
        
        def activate
          @ticket = Ticket.find(params[:id])
          if @ticket.update_attribute(:used, "Expired")
            redirect_to admin_tickets_path
          else
            render root_path
          end 
        end

        def destroy
          @ticekt = Ticket.find(params[:id])
          @ticket.destroy
          redirect_to admin_tickets_url, :notice => "Successfully deleted a ticket."
        end
end
