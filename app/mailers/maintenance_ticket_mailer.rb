# encoding: utf-8

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
    status = if ticket_created?
      "crée"
    elsif @ticket.state == "Fermé"
      "clôturé"
    else
      "modifié"
    end

    "Ticket numéro #{@ticket.id} #{status}"
  end

end
