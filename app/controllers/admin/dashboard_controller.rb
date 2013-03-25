class Admin::DashboardController < Admin::AdminBaseController
  def index
    @tickets2 = Ticket.all
    if !@tickets2
      @tickets2.each do |t|
        @adult = t.adult_tickets_bought
        @concession = t.concession_tickets_bought
        @total = (@adult * 5) + (@concession * 3)
      end
    else
          @adult = 0
          @concession = 0
          @total = 0
    end
  end
end
