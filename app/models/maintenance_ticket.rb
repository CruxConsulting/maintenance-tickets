class MaintenanceTicket < ActiveRecord::Base

  # Associations
  ##############

  belongs_to :client

  # Validations
  #############

  validates :client_id, presence: true

  # Callbacks
  ###########

  after_save :notify

  # Instance methods
  ##################

  delegate :name, :email, to: :client, prefix: true

  def notify
    return unless created_at_changed? || closed?

    emails = recipients.split(',').map(&:strip) | [ENV['MAINTENANCE_TICKET_NOTIFICATION_EMAIL'], client_email].compact

    MaintenanceTicketMailer.send_ticket_infos(self, emails)
      .deliver_now unless emails.empty?
  end

  def opened?
    state == 'Ouvert'
  end

  def closed?
    state == 'Fermé'
  end

end
