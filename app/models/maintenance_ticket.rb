class MaintenanceTicket < ActiveRecord::Base
  attr_accessible :client_email, :client_name, :comment, :maintained_by, :state

  # Callbacks
  ###########

  after_create :notify

  # Instance methods
  ##################

  def notify
    recipients = [ENV["MAINTENANCE_TICKET_NOTIFICATION_EMAIL"], self.client_email].compact
    MaintenanceTicketMailer.send_ticket_infos(self, recipients).deliver unless recipients.empty?
  end

end
