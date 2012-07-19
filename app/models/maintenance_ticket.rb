class MaintenanceTicket < ActiveRecord::Base
  attr_accessible :client_email, :client_name, :comment, :maintained_by, :state
end
