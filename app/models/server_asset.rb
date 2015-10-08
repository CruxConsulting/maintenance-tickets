class ServerAsset < Asset
  has_many :disks
  has_many :monthly_reports

  accepts_nested_attributes_for :disks, allow_destroy: true
end
