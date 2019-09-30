ActiveAdmin.register Client do

  filter :name
  filter :email
  filter :comment
  filter :under_contract

  config.sort_order = 'name_asc'

  menu priority: 0

  # Views
  #######

  index do
    column :name
    column :email
    column :under_contract
    actions
  end

  show do
    attributes_table do
      row :name
      row :email

      row :under_contract do |client|
        client.under_contract? ? 'oui' : 'non'
      end

      row :comment do |client|
        simple_format client.comment
      end
    end

    panel 'Objets' do
      table_for resource.assets.order(:type, expiration_date: :desc) do
        column :type do |asset|
          asset.class.model_name.human
        end
        column 'Nom', :name
        column :description do |asset|
          simple_format asset.description
        end
        column "Date d'expiration", :expiration_date do |asset|
          l asset.expiration_date, format: :long
        end
        column do |asset|
          link_to 'Modifier', [:edit, :admin, asset]
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :under_contract
      f.input :comment, input_html: { rows: 10 }
    end

    f.actions
  end

end
