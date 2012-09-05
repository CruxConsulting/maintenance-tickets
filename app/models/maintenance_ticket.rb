class MaintenanceTicket < ActiveRecord::Base

  # Attributes
  ############

  attr_accessible :comment, :maintained_by, :state, :client_id

  # Associations
  ##############

  belongs_to :client

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
