class Disk < ActiveRecord::Base
  belongs_to :server_asset, foreign_key: 'asset_id'

  def storage_left
    total_storage - used_storage
  end
end
