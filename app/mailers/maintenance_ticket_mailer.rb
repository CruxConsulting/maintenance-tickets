class MaintenanceTicketMailer < ActionMailer::Base
  default from: "support@asconseil.eu"

  def send_ticket_infos(ticket)
    @ticket = ticket
    mail(:to => ENV["MAINTENANCE_TICKET_NOTIFICATION_EMAIL"], :subject => "notification: Nouveau ticket de maintenance")
  end

end
