class MaintenanceTicketMailer < ActionMailer::Base
  default from: "support@asconseil.eu"

  def send_ticket_infos(ticket, recipients)
    @ticket = ticket
    mail(to: recipients, :subject => "notification: Nouveau ticket de maintenance")
  end

end
