class AddTicketDateToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :ticket_date, :date
  end
end
