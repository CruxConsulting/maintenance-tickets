class MaintenanceTicket < ActiveRecord::Base

  # Attributes
  ############

  attr_accessible :comment, :maintained_by, :state, :client_id

  # Associations
  ##############

  belongs_to :client

  # Validations
  #############

  validates :client_id, presence: true

  # Callbacks
  ###########

  after_create :notify

  # Instance methods
  ##################

  delegate :name, :email, to: :client, prefix: true

  def notify
    recipients = [
      ENV["MAINTENANCE_TICKET_NOTIFICATION_EMAIL"], client_email].compact
    MaintenanceTicketMailer.send_ticket_infos(self, recipients).deliver unless recipients.empty?
  end

end
