class MonthlyReportPDF
  include Prawn::View
  include ActionView::Helpers::NumberHelper

  def initialize(monthly_report)
    @monthly_report = monthly_report
    @document = Prawn::Document.new page_size: 'A4',
                                    margin: [20, 20, 20, 20]

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
    bounding_box([250, 750], width: 200, height: 50) do
      # stroke_bounds
      text 'Visite Mensuelle', size: 20, style: :bold
    end

    bounding_box([200, 700], width: 100, height: 80) do
      # stroke_bounds
      text 'Date:', style: :bold
      text 'Nom du client:', style: :bold
      text 'Intervenant:', style: :bold
      text 'Nom Serveur:', style: :bold
    end

    bounding_box([300, 700], width: 250, height: 80) do
      # stroke_bounds
      text @monthly_report.display_name
      text @monthly_report.client_name
      text @monthly_report.tech
      text @monthly_report.server_asset_name
    end
  end

  def backup
    bounding_box([50, 600], width: 500, height: 100) do
      # stroke_bounds
      text 'Sauvegarde :', style: :bold, size: 16

      bounding_box([0, 70], width: 80, height: 50) do
        # stroke_bounds
        text 'Veille :', style: :bold
        text 'Derniers jours :', style: :bold
      end

      bounding_box([80, 70], width: 70, height: 50) do
        # stroke_bounds
        text @monthly_report.last_backup_state
        text @monthly_report.previous_backups_state
      end

      bounding_box([150, 70], width: 100, height: 50) do
        # stroke_bounds
        text 'Raison', style: :bold
        text 'Raison principale', style: :bold
      end

      bounding_box([250, 70], width: 250, height: 50) do
        # stroke_bounds
        text @monthly_report.last_backup_reason
        text @monthly_report.previous_backups_reason
      end
    end
  end

  def restore
    bounding_box([50, 520], width: 500, height: 50) do
      # stroke_bounds
      text 'Restauration :', style: :bold, size: 16

      bounding_box([0, 20], width: 80, height: 20) do
        # stroke_bounds
        text 'Résultat :', style: :bold
      end

      bounding_box([80, 20], width: 70, height: 20) do
        # stroke_bounds
        text @monthly_report.restore_state
      end

      bounding_box([150, 20], width: 100, height: 20) do
        # stroke_bounds
        text 'Raison', style: :bold
      end

      bounding_box([250, 20], width: 250, height: 20) do
        # stroke_bounds
        text @monthly_report.restore_reason
      end
    end
  end

  def disks
    bounding_box([50, 440], width: 500, height: 100) do
      # stroke_bounds
      text 'Elements fonctionnels :', style: :bold, size: 16

      bounding_box([0, 70], width: 100, height: 70) do
        # stroke_bounds
        text "Disque durs :", style: :bold
        @monthly_report.disks.each do |disk|
          text "Espace partition #{disk.name}", style: :bold
        end
      end

      bounding_box([100, 70], width: 100, height: 70) do
        # stroke_bounds
        text @monthly_report.hard_drives_state
        @monthly_report.disks.each do |disk|
          text disk.state
        end
      end

      bounding_box([200, 70], width: 150, height: 70) do
        # stroke_bounds
        text "Nombre de disques HS: #{@monthly_report.hard_drives_down}"
        @monthly_report.disks.each do |disk|
          text "Capacité restante: #{disk.storage_left} Go"
        end
      end
    end
  end

  def antivirus
    bounding_box([50, 320], width: 500, height: 70) do
      # stroke_bounds
      text 'Protection Virale et Nuisible :', style: :bold, size: 16

      bounding_box([0, 40], width: 120, height: 40) do
        # stroke_bounds
        text 'Logiciel fonctionnel :', style: :bold
        text 'Logiciel à jour (<5jrs) :', style: :bold
      end

      bounding_box([120, 40], width: 80, height: 40) do
        # stroke_bounds
        text %w(oui non).sample
        text %w(oui non).sample
      end

    end
  end

  def notes
    bounding_box([50, 240], width: 500, height: 70) do
      # stroke_bounds
      text 'Remarques :', style: :bold, size: 16

      text @monthly_report.notes
    end
  end

  def footer
    repeat(:all) do
    end
  end

  private

  def setup_defaults
    font_size 10
    default_leading 3
  end

  def client_info
    text @monthly_report.client_name
    text @monthly_report.client_address
    text "#{@monthly_report.client_zip_code} #{@monthly_report.client_city}"
  end

end
