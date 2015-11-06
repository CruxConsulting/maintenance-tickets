class ServerAsset < Asset
  has_many :disks
  has_many :monthly_reports

  accepts_nested_attributes_for :disks, allow_destroy: true

  # Instance methods
  ##################

  delegate :date, to: :lastest_montly_report, prefix: true, allow_nil: true

  def lastest_montly_report
    monthly_reports.order(date: :desc).first
  end
end
