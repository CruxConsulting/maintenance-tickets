class ServerAsset < Asset
  has_many :disks
  has_many :monthly_reports

  accepts_nested_attributes_for :disks, allow_destroy: true

  clear_validators!

  # Scopes
  ########

  scope :without_monthly_report, -> {
    includes(:monthly_reports).where(monthly_reports: {id: nil})
  }
end
