class MonthlyReportPDF
  include Prawn::View
  include ActionView::Helpers::NumberHelper

  def initialize(invoice)
    @invoice = invoice
    @document = Prawn::Document.new(page_size: "A4", margin: [96, 57, 20, 57])

    setup_fonts
    setup_defaults
  end

  def filename
    "#{@invoice.number}.pdf"
  end

  def header
    image (Rails.public_path + "images/logo-full-transparent.png").to_s,
    :at => [bounds.right - 96, bounds.top + 61]
  end

  def cartouche
    move_down 13
    text "Facture", size: 32, style: :ultra_light

    move_down 12
    text I18n.l(@invoice.invoiced_on, format: :default), align: :right

    move_down 45
    text "Numéro de facture : #{@invoice.number}"

    move_down 21
    text "A l’attention de :", style: :bold
    client_info
  end

  def content
    move_down 16
    data1 = [["Prestation", "Total (HT)"]]

    @invoice.lines.each do |line|
      data1 << [line.description, number_to_currency(line.amount_excl_vat, precision: 2)]
    end

    table data1, :width => bounds.width, column_widths: [bounds.width/4*3, bounds.width/4], header: true do
      rows(0).text_color = "FFFFFF"
      rows(0).font_style = :bold
      rows(0).background_color = "367DA2"
      rows(0).align = :center
      rows(0).border_width = 0.5

      (row_length - 1).times do |i|
        row_index = i + 1
        rows(row_index).last.align = :center
        rows(row_index).border_width = 0.5
      end
    end

    move_down 24

    data2 = [
      ["Total Hors-Taxe", number_to_currency(@invoice.amount_excl_vat, precision: 2)],
      ["TVA 20,0%", number_to_currency(@invoice.amount_excl_vat * @invoice.vat, precision: 2)]
    ]

    table data2, :width => bounds.width, column_widths: [bounds.width/4*3, bounds.width/4] do
      row_length.times do |i|
        rows(i).last.align = :center
        rows(i).border_width = 0.5
      end
    end

    move_down 24
    data3 = [["Total TTC", number_to_currency(@invoice.amount_incl_vat, precision: 2)]]

    table data3, :width => bounds.width, column_widths: [bounds.width/4*3, bounds.width/4] do
      rows(0).last.align = :center
      rows(0).border_width = 0.5
    end
  end

  def iban
    move_down 38
    data = [
      [{content: "Informations Bancaires", colspan: 2}],
      ["IBAN", "BIC"],
      ["FR60 2004 1010 1608 3110 4R03 703", "PSSTFRPPTOU"]
    ]

    table data, :column_widths => [bounds.width/3, bounds.width/3] do
      rows(0).text_color = "FFFFFF"
      rows(0).font_style = :bold
      rows(0).background_color = "367DA2"
      rows(0).align = :center
      rows(0).border_width = 0.5

      rows(1).font_style = :bold
      rows(1).size = 7
      rows(1).align = :center
      rows(1).border_width = 0.5

      rows(2).size = 7
      rows(2).align = :center
      rows(2).border_width = 0.5
    end
  end

  def footer
    repeat(:all) do
      bounding_box([0, 50], width: bounds.width) do
        text "Crux Consulting - SARL au capital de 5 000 €", align: :center, size: 7, style: :bold
        text "N° TVA intracommunautaire : FR 71 512 631 375 - RCS Montauban", align: :center, size: 7, style: :bold
        text "70 impasse de Varsovie - 82000 Montauban", align: :center, size: 7
        text "06 07 47 85 87 - <u><link href='mailto:julien@crx.io'>julien@crx.io</link></u> - <u><link href='http://www.crx.io'>www.crx.io</link></u>", align: :center, size: 7, inline_format: true
      end
    end
  end

  private

  def setup_fonts
    font_families.update("Helvetica Neue" => {
      :normal           => { :file => (Rails.root + "vendor/fonts/HelveticaNeue.ttf").to_s, :font => 0 },
      :bold           => { :file => (Rails.root + "vendor/fonts/HelveticaNeueBold.ttf").to_s, :font => 0 },
      :light      => { :file => (Rails.root + "vendor/fonts/HelveticaNeueLight.ttf").to_s, :font => 0 },
      :ultra_light      => { :file => (Rails.root + "vendor/fonts/HelveticaNeueUltraLight.ttf").to_s, :font => 0 }
    })
  end

  def setup_defaults
    font "Helvetica Neue", style: :light
    font_size 9
    default_leading 3
  end

  def client_info
    text @invoice.client_name
    text @invoice.client_address
    text "#{@invoice.client_zip_code} #{@invoice.client_city}"
  end

end
