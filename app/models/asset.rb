class Asset < ActiveRecord::Base

  # Associations
  ##############
  belongs_to :client

  # Class methods
  ###############

  # expire in 30 days or less
  scope :expire_soon, -> {
    t = arel_table
    where(t[:expiration_date].lt Time.zone.today + 30)
  }

end
