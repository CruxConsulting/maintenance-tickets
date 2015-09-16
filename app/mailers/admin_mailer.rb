class AdminMailer < ActionMailer::Base

  default from: 'direction@asconseil.eu'

  def assets_expire_soon
    @assets = Asset.expire_soon.includes(:client).order(expiration_date: :desc)
    mail(
      to: 'direction@asconseil.eu',
      subject: 'Des objets arrivent bientôt à expiration'
    )
  end

end
