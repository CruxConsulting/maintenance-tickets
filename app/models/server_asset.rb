class ServerAsset < Asset
  has_many :disks
  has_many :monthly_reports

  accepts_nested_attributes_for :disks, allow_destroy: true

  # Scopes
  ########

  scope :without_monthly_report, -> {
    includes(:monthly_reports).where(monthly_reports: {id: nil})
  }

  # Instance methods
  ##################

  delegate :date, to: :lastest_monthly_report, prefix: true, allow_nil: true

  def lastest_monthly_report
    monthly_reports.sort_by(&:date).last
  end
end
