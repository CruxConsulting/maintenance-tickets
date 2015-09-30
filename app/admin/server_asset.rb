ActiveAdmin.register ServerAsset do

  menu parent: 'Objets'

  filter :client
  filter :name

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client)
    end
  end

  index do
    column :client
    column :name
    column :description do |resource|
      simple_format resource.description
    end
    column :quantity
    column :expiration_date do |resource|
      l resource.expiration_date, format: :long
    end

    actions do |resource|
      link_to MonthlyReport.model_name.human(count: 2),
              admin_server_asset_monthly_reports_path(resource),
              class: 'member_link'
    end
  end

  show do
    attributes_table do
      row :client
      row :name
      row :description do
        simple_format resource.description
      end
      row :quantity do
        server_memory resource
      end
      row :expiration_date do
        l resource.expiration_date, format: :long
      end
    end

    panel Disk.model_name.human(count: resource.disks.size) do
      table_for resource.disks.order(:name) do
        column 'Partition', :name
        column 'Capacité totale' do |r|
          "#{r.total_storage} Go" if r.total_storage
        end
        column 'Capacité utilisée' do |r|
          "#{r.used_storage} Go" if r.used_storage
        end
        column 'Capacité restante' do |r|
          "#{r.storage_left} Go" if r.storage_left
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :client
      f.input :name
      f.input :description
      f.input :quantity, hint: 'Go'
      f.input :expiration_date
    end

    f.has_many :disks do |ff|
      ff.input :name
      ff.input :total_storage, hint: 'Go'
      ff.input :used_storage, hint: 'Go'
    end

    f.actions
  end

end
