class AddRecipientsToMonthlyReports < ActiveRecord::Migration
  def change
    add_column :monthly_reports, :additional_recipients, :string
  end
end
