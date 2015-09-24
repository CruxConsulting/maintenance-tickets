class ServerAsset < Asset
  has_many :disks, foreign_key: 'asset_id'

  accepts_nested_attributes_for :disks
end
