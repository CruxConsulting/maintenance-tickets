ActiveAdmin.register Asset do

  client_select2_options = {
    placeholder: "Choisir un client",
    resourcesPath: "/admin/clients",
    queryKey: "q[name_cont]",
    order: "name_asc",
    resultFormat: "data.name"
  }

  select2_filter :client_id, input_html: {data: {
    select2_options: client_select2_options
  }}

  filter :name

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client)
    end
  end

  index do
    column :client
    column :name
    column :expiration_date do |resource|
      l resource.expiration_date, format: :long
    end
    actions
  end

  show do
    attributes_table do
      row :client
      row :name
      row :description do
        simple_format resource.description
      end
      row :expiration_date do
        l resource.expiration_date, format: :long
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :client_id, as: :select2, select2_options: client_select2_options
      f.input :name
      f.input :description
      f.input :expiration_date
    end

    f.actions
  end

end
