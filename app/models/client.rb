class Client < ActiveRecord::Base

  # Validations
  #############

  validates :name, presence: true
  validates :email, presence: true, format: {with: Devise.email_regexp}

  # Associations
  ##############

  has_many :maintenance_tickets

end
