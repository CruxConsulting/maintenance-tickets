ActiveAdmin.register Asset do

  menu parent: 'Objets'

  config.sort_order = 'expiration_date_asc'

  actions :index

  filter :client
  filter :name
  filter :description
  filter :expiration_date

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client)
    end
  end

  index do
    column :type do |asset|
      link_to [asset.class.model_name.human, asset.id].join(' '), polymorphic_url([:admin, asset])
    end
    column :name
    column :client
    column :expiration_date do |resource|
      l resource.expiration_date, format: :long if resource.expiration_date
    end

    actions
  end

  show do
    attributes_table do
      row :client
      row :name
      row :expiration_date do
        l resource.expiration_date, format: :long
      end
      row :description do
        simple_format resource.description
      end
    end
  end

end
