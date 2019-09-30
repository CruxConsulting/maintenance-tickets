class AdminMailer < ActionMailer::Base

  default from: 'luc.colon@sowilo-network.com'

  def assets_expire_soon
    @assets = Asset.expire_soon.includes(:client).order(expiration_date: :desc)
    mail(
      to: 'direction34@sowilo-network.com',
      subject: 'Des objets arrivent bientôt à expiration'
    )
  end

  def send_charge_details(ticket)
    @ticket = ticket
    recipient = ENV["CHARGE_DETAILS_EMAIL"] || 'luc.colon@sowilo-network.com'
    mail to: recipient, subject: "Détails de facturation du ticket #{@ticket.id}"
  end

end
