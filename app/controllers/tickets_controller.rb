class TicketsController < ApplicationController
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
      redirect_to root_path
    else
      render 'new'
    end
  end
end
