class TicketMailer < ActionMailer::Base
  helper :application
  default from: 'victoryliesahead@gmail.com'
 def ticket_email(ticket)
   @ticket = ticket
    mail(:to => ticket.email, :subject => "Ticket Confirmation",template_path: 'ticket_mailer',template_name: 'ticket_email')
  end
end
