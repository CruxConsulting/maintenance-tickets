class MaintenanceTicketMailer < ActionMailer::Base
  default from: "support@asconseil.eu"

  def send_ticket_infos(ticket)
    @ticket = ticket
    mail(:to => "support@asconseil.eu", :subject => "notification: Nouveau ticket de maintenance").inspect
  end

end
