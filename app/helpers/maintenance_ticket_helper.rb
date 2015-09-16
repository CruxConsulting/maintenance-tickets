module MaintenanceTicketHelper
  def ticket_assigned_to_human(ticket)
    ticket.assigned_to.join(' et ')
  end
end
