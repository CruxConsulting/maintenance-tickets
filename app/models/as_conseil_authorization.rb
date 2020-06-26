class AssetMatcher
  def ===(other)
    ancestors = other.class === Class ? other.ancestors : other.class.ancestors
    ancestors.include?(Asset)
  end
end

class AsConseilAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    return true if user.username == "crux"
    return true if (ENV["ADMINS"] || []).split(',').include? user.username

    case subject
    when normalized(AdminUser)
      false
    when normalized(PhoneAsset)
      (ENV["PHONE_ADMINS"] || []).split(',').include? user.username
    when AssetMatcher.new
      false
    else
      true
    end
  end

end
