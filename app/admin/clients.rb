ActiveAdmin.register Client do

  filter :name
  filter :email
  filter :comment

  config.sort_order = "name_asc"

  # Views
  #######

  index do
    column :name
    column :email
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :comment do |client|
        simple_format client.comment
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :comment, :input_html => { :rows => 10 }
    end

    f.buttons
  end

end
