class AddShouldChargeToMaintenanceTickets < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :should_charge, :boolean, default: false
    add_column :maintenance_tickets, :charge_details, :text
  end
end
