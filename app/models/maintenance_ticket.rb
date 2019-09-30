class MaintenanceTicket < ActiveRecord::Base

  # Constants
  ###########

  MAINTAINED_BY = [
    'Téléphone',
    'Prise de main',
    'Sur site',
    'Atelier',
    'Email'
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
  validates :duration, presence: true
  validates :maintenance_date, presence: true
  validates :charge_details, presence: true, if: Proc.new { |ticket| ticket.should_charge? }

  # Callbacks
  ###########

  before_save :_remove_blank_from_assigned_to
  after_save :notify
  after_save :_send_charge_details, if: Proc.new {|ticket| ticket.should_charge? }

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

  def _send_charge_details
    AdminMailer.send_charge_details(self).deliver_now
  end

  def _remove_blank_from_assigned_to
    assigned_to.reject!(&:blank?)
  end

end
