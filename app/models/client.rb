class Client < ActiveRecord::Base
  attr_accessible :email, :name

  default_scope order(:name)

  # Associations
  ##############

  has_many :maintenance_tickets

end
