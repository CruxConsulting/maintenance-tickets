class Disk < ActiveRecord::Base
  belongs_to :server_asset

  def storage_left
    total_storage - used_storage
  end
end
