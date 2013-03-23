class TicketsController < ApplicationController
  def new
  	@ticket = Ticket.new
	end

  def index
    @tickets = Ticket.order(sort_column(Ticket) + " " + sort_direction)
  end
  def show
    @tickets = Ticket.find(params[:id])
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
  def send_mail
    for i in 0..24
      @ticket = Ticket.new(params[:ticket])
      @ticket.order_id = generate_ticket_id()
      if @ticket.save
        test = "success"
      else
        test = "fail"
      end
    end
    if test == "success"
      flash[:success] = test
      redirect_to root_path
      TicketMailer.ticket_email(@ticket).deliver
    else
      flash[:success] = test
      redirect_to root_path
    end
  end
end
