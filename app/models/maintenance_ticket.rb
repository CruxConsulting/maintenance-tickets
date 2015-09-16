class MaintenanceTicket < ActiveRecord::Base

  # Constants
  ###########

  MAINTAINED_BY = [
    'Téléphone',
    'Prise de main',
    'Sur site',
    'Atelier'
  ]

  STATES = [
    'Ouvert',
    'Ouvert - Attente client',
    'Ouvert - Attente fournisseur',
    'Ouvert - Urgent',
    'Fermé'
  ]

  TECH_PEOPLE = ENV['TECH_PEOPLE'].split(',')

  # Associations
  ##############

  belongs_to :client

  # Validations
  #############

  validates :client_id, presence: true

  # Callbacks
  ###########

  before_save :_remove_blank_from_assigned_to
  after_save :notify

  # Instance methods
  ##################

  delegate :name, :email, to: :client, prefix: true

  def notify(options = {force: false})
    return unless options[:force] == true || created_at_changed? || closed?

    emails = recipients.split(',').map(&:strip) | [ENV['MAINTENANCE_TICKET_NOTIFICATION_EMAIL'], client_email].compact

    MaintenanceTicketMailer.send_ticket_infos(self, emails)
      .deliver_now unless emails.empty?
  end

  def opened?
    !(state =~ /Ouvert/).nil?
  end

  def closed?
    state == 'Fermé'
  end

  private

  def _remove_blank_from_assigned_to
    assigned_to.reject!(&:blank?)
  end

end
