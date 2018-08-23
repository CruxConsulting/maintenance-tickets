class AdminMailer < ActionMailer::Base

  default from: 'luc.colon@sowilo-network.com'

  def assets_expire_soon
    @assets = Asset.expire_soon.includes(:client).order(expiration_date: :desc)
    mail(
      to: 'luc.colon@sowilo-network.com',
      subject: 'Des objets arrivent bientôt à expiration'
    )
  end

end
