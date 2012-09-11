class MaintenanceTicketMailer < ActionMailer::Base
  default from: "support@asconseil.eu"

  def send_ticket_infos(ticket, recipients)
    @ticket = ticket
    mail to: recipients, :subject => send_ticket_subject
  end

  private

  def ticket_created?
    @ticket.created_at_changed?
  end

  def send_ticket_subject
    subject = if ticket_created?
      "notification: Nouveau ticket de maintenance"
    else
      "notification: Modification d'un ticket de maintenance"
    end

  end

end
