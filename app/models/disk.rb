class Disk < ActiveRecord::Base

  # Constants
  ###########

  STATES = %w(Ok Acceptable Dangereux)

  belongs_to :server_asset

  def storage_left
    total_storage - used_storage
  end

end
