class MaintenanceTicket < ActiveRecord::Base
  attr_accessible :client_email, :client_name, :comment, :maintained_by, :state

  # Callbacks
  ###########

  after_create :notify

  # Instance methods
  ##################

  def notify
    MaintenanceTicketMailer.send_ticket_infos(self).deliver if ENV["MAINTENANCE_TICKET_NOTIFICATION_EMAIL"].present?
  end

end
