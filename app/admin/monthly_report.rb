ActiveAdmin.register MonthlyReport do

  belongs_to :server_asset

  member_action :save_pdf do
    notice = resource.pdf? ? 'PDF updated' : 'PDF saved'
    resource.save_pdf
    redirect_to admin_server_asset_monthly_reports_path(resource.server_asset),
                notice: notice
  end

  action_item :save_pdf, only: :show do
    link_to 'Enregistrer le PDF',
            save_pdf_admin_server_asset_monthly_report_path(
              resource.server_asset,
              resource
            )
  end

  index do
    column :client
    column :server_asset
    column :date do |resource|
      l resource.date, format: '%B %Y'
    end

    actions
  end

  show do
    panel 'Cartouche' do
      attributes_table_for resource do
        row :date do
          l resource.date, format: '%B %Y'
        end
        row :client
        row :tech
        row :server_asset
      end
    end

    panel 'Sauvegarde' do
      attributes_table_for resource do
        row :last_backup_state
        row :last_backup_reason
        row :previous_backups_state
        row :previous_backups_reason
      end
    end

    panel 'Restauration' do
      attributes_table_for resource do
        row :restore_state
        row :restore_reason
      end
    end

    panel 'Éléments fonctionnels' do
      table_for :disks do
        # column :partition
        # column :total_storage
        # column :storage_left
      end
    end

    panel 'Protection Virale et Nuisible' do
    end

    panel 'Remarques' do
      attributes_table_for resource do
        row :notes do
          simple_format resource.notes
        end
      end
    end

    panel 'PDF' do
      link_to resource['pdf'], resource.pdf.url if resource.pdf?
    end

  end

  form do |f|
    f.inputs 'Cartouche' do
      f.input :date,
              as: :date_select,
              order: [:month, :year],
              start_year: Time.zone.today.year

      f.input :client, input_html: {disabled: true}
      f.input :tech, as: :select, collection: ENV['TECH_PEOPLE'].split(',')
      f.input :server_asset, input_html: {disabled: true}
    end

    f.inputs 'Sauvegarde' do
      f.input :last_backup_state,
              as: :radio,
              collection: resource.class::BACKUP_STATES

      f.input :last_backup_reason,
              input_html: {rows: 1}
      f.input :previous_backups_state,
              as: :radio,
              collection: resource.class::BACKUP_STATES

      f.input :previous_backups_reason,
              input_html: {rows: 1}
    end

    f.inputs 'Restauration' do
      f.input :restore_state,
              as: :radio,
              collection: resource.class::BACKUP_STATES

      f.input :restore_reason,
              input_html: {rows: 1}
    end

    f.inputs 'Éléments fonctionnels' do
      f.has_many :disks, new_record: false do |ff|
        ff.input :name
        ff.input :total_storage, hint: 'Go'
        ff.input :used_storage, hint: 'Go'

      end
    end

    f.inputs 'Protection Virale et Nuisible' do
    end

    f.inputs 'Remarques' do
      f.input :notes, input_html: {rows: 3}
    end

    f.actions
  end

end
