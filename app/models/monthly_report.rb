class MonthlyReport < ActiveRecord::Base

  BACKUP_STATES = %w(Terminé Incomplet Échec)

  belongs_to :server_asset
  has_one :client, through: :server_asset
  has_many :disks, through: :server_asset

  accepts_nested_attributes_for :disks

  validates_presence_of :server_asset

  after_initialize do
    self.date = Time.zone.today unless persisted?
  end

  def display_name
    I18n.l date, format: '%B %Y'
  end

  delegate :id, to: :client, prefix: true
end
