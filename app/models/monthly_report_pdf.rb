class MonthlyReportPDF
  include Prawn::View
  include ActionView::Helpers::NumberHelper

  def initialize(monthly_report)
    @monthly_report = monthly_report
    @document = Prawn::Document.new page_size: 'A4',
                                    margin: [20, 57, 20, 20]

    setup_defaults
  end

  def filename
    "#{@monthly_report.full_name}.pdf"
  end

  def background
    image(
      (Rails.public_path + 'images/monthly_report_background.jpg').to_s,
      at: [bounds.left, bounds.top]
    )
  end

  def cartouche
    bounding_box([250, 700], width: 200, height: 50) do
      stroke_bounds
      text 'Visite Mensuelle', size: 20, style: :bold
    end

    bounding_box([200, 650], width: 100, height: 80) do
      stroke_bounds
      text 'Date:', style: :bold
      text 'Nom du client:', style: :bold
      text 'Intervenant:', style: :bold
      text 'Nom Serveur:', style: :bold
    end

    bounding_box([300, 650], width: 250, height: 80) do
      stroke_bounds
      text @monthly_report.display_name
      text @monthly_report.client_name
      text @monthly_report.tech
      text @monthly_report.server_asset_name
    end
  end

  def backup
    bounding_box([50, 550], width: 500, height: 100) do
      stroke_bounds
      text 'Sauvegarde :', style: :bold, size: 16

      bounding_box([0, 70], width: 100, height: 50) do
        stroke_bounds
        text 'Veille :', style: :bold
        text 'Derniers jours :', style: :bold
      end

      bounding_box([110, 70], width: 80, height: 50) do
        stroke_bounds
        text @monthly_report.last_backup_state
        text @monthly_report.previous_backups_state
      end

      bounding_box([200, 70], width: 120, height: 50) do
        stroke_bounds
        text 'Raison', style: :bold
        text 'Raison principale', style: :bold
      end

      bounding_box([340, 70], width: 160, height: 50) do
        stroke_bounds
        text @monthly_report.last_backup_reason
        text @monthly_report.previous_backups_reason
      end
    end
  end

  def restore
  end

  def disks
  end

  def antivirus
  end

  def notes
  end


  def footer
    repeat(:all) do
      bounding_box([0, 50], width: bounds.width) do
        text 'Crux Consulting - SARL au capital de 5 000 €',
             align: :center,
             size: 7,
             style: :bold

        text 'N° TVA intracommunautaire : FR 71 512 631 375 - RCS Montauban',
             align: :center,
             size: 7,
             style: :bold

        text '70 impasse de Varsovie - 82000 Montauban',
             align: :center,
             size: 7

        text "06 07 47 85 87 - <u><link href='mailto:julien@crx.io'>julien@crx.io</link></u> - <u><link href='http://www.crx.io'>www.crx.io</link></u>",
             align: :center,
             size: 7,
             inline_format: true

      end
    end
  end

  private

  def setup_defaults
    font_size 12
    default_leading 3
  end

  def client_info
    text @monthly_report.client_name
    text @monthly_report.client_address
    text "#{@monthly_report.client_zip_code} #{@monthly_report.client_city}"
  end

end
