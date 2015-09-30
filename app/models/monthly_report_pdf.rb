class MonthlyReportPDF
  include Prawn::View
  include ActionView::Helpers::NumberHelper

  def initialize(monthly_report)
    @monthly_report = monthly_report
    @document = Prawn::Document.new page_size: 'A4',
                                    margin: [96, 57, 20, 57]

    setup_defaults
  end

  def filename
    "#{@monthly_report.full_name}.pdf"
  end

  def background
    image(
      (Rails.public_path + 'images/monthly_report_background.jpg').to_s,
      at: [bounds.right - 96, bounds.top + 61]
    )
  end

  def cartouche
    move_down 13
    text 'Facture', size: 32
  end

  def backup
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
    font 'Helvetica'#, style: :normal
    font_size 9
    default_leading 3
  end

  def client_info
    text @monthly_report.client_name
    text @monthly_report.client_address
    text "#{@monthly_report.client_zip_code} #{@monthly_report.client_city}"
  end

end
