# encoding: utf-8

class MaintenanceTicketMailer < ActionMailer::Base

  add_template_helper(MaintenanceTicketHelper)
  add_template_helper(ApplicationHelper)

  default from: 'support@asconseil.eu'

  def send_ticket_infos(ticket, recipients)
    @ticket = ticket
    mail to: recipients, subject: send_ticket_subject
  end

  def send_montly_report(monthly_report)
    @monthly_report              = monthly_report
    attachment_name              = 'Visite mensuelle - ' \
                                   "#{monthly_report.display_name}.pdf"
    attachment_content           = monthly_report.pdf.file.read
    attachments[attachment_name] = attachment_content

    mail to: monthly_report.recipients,
         bcc: 'direction@asconseil.eu',
         subject: "Visite Mensuelle : #{monthly_report.display_name}"
  end

  private

  def ticket_created?
    @ticket.created_at_changed?
  end

  def send_ticket_subject
    status = if ticket_created?
               'crée'
             elsif @ticket.closed?
               'clôturé'
             end

    "Ticket numéro #{@ticket.id} #{status} - #{@ticket.client_name}"
  end

end
