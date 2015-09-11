class AdminMailer < ActionMailer::Base

  default from: 'direction@asconseil.eu'

  def assets_expire_soon
    @assets = Asset.expire_soon.includes(:client)
    mail(
      to: 'direction@asconseil.eu',
      subject: 'Des objets arrivent bientôt à expiration'
    )
  end

end
