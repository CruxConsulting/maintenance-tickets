class MaintenanceTicketMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_ticket_infos(ticket)
    mail(:to => "bastien@cruxandco.com", :subject => "the mail subject").inspect
  end

end
