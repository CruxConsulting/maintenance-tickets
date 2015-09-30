ActiveAdmin.register MonthlyReport do

  belongs_to :server_asset

  filter :client

  index do
    column :client
    column :server_asset
    column :date do |resource|
      l resource.date, format: "%B %Y"
    end

    actions
  end

  show do
    attributes_table do
      row :client
      row :server_asset
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
      f.input :notes, label: false
    end

    f.actions
  end

end
