class Client < ActiveRecord::Base

  # Attributes
  ############

  attr_accessible :email, :name, :comment

  # Validations
  #############

  validates :name, presence: true
  validates :email, presence: true, format: {with: Devise.email_regexp}

  # Associations
  ##############

  has_many :maintenance_tickets

end
