class Client < ActiveRecord::Base
  attr_accessible :email, :name

  # Associations
  ##############

  has_many :maintenance_tickets

end
