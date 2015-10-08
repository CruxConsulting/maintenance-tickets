ActiveAdmin.register MonthlyReport do

  belongs_to :server_asset

  member_action :save_pdf do
    resource.save_pdf
    redirect_to resource.pdf.url

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

    actions do |resource|
      if resource.pdf?
        link_to 'PDF', resource.pdf.url, class: 'member_link'
      else
        link_to 'Enregistrer le PDF',
                save_pdf_admin_server_asset_monthly_report_path(
                  resource.server_asset,
                  resource
                ),
                class: 'member_link'
      end
    end
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
      attributes_table_for resource do
        row :hard_drives_state
        row :hard_drives_down
      end
      table_for resource.disks do
        column 'partition', :name
        column 'État', :state
        column 'Capacité totale (Go)', :total_storage
        column 'Capacité restante (Go)', :storage_left
      end
    end

    panel 'Protection Virale et Nuisible' do
      attributes_table_for resource do
        row :software_working do
          resource.software_working? ? 'Oui' : 'Non'
        end
        row :licence_up_to_date do
          resource.licence_up_to_date? ? 'Oui' : 'Non'
        end
      end
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
      f.input :hard_drives_state,
              as: :radio,
              collection: MonthlyReport::HARD_DRIVE_STATES

      f.input :hard_drives_down,
              input_html: {min: 0}

      f.has_many :disks, new_record: false do |ff|
        ff.input :name
        ff.input :total_storage, hint: 'Go'
        ff.input :used_storage, hint: 'Go'
        ff.input :state, as: :radio, collection: Disk::STATES
      end
    end

    f.inputs 'Protection Virale et Nuisible' do
      f.input :software_working
      f.input :licence_up_to_date
    end

    f.inputs 'Remarques' do
      f.input :notes, input_html: {rows: 3}
    end

    f.actions
  end

end
