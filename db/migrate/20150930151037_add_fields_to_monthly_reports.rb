class AddFieldsToMonthlyReports < ActiveRecord::Migration
  def change
    add_column :monthly_reports, :hard_drives_state, :string, default: 'Ok'
    add_column :monthly_reports, :hard_drives_down, :integer, default: 0
  end
end
