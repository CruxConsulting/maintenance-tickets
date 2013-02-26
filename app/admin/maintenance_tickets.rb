# encoding: UTF-8

ActiveAdmin.register MaintenanceTicket do

  config.sort_order = "state_desc"

  index do
    column :id
    column :client
    column :maintained_by
    column :description
    column :comment
    column :state
    column :created_at
    default_actions
  end

  show do
    attributes_table do
      row :maintained_by
      row :comment do |ticket|
        simple_format ticket.comment
      end
      row :state
      row :created_at
      row :updated_at
      row :client
      row :description do |ticket|
        simple_format ticket.description
      end
      row :assigned_to
      row :duration
      row :recipients
    end
  end

  form do |f|
    f.inputs do

      f.input :maintained_by, as: :select, collection:
      {
        "Téléphone" => "Téléphone",
        "Prise de main" => "Prise de main",
        "Sur site" => "Sur site"
        }, include_blank: false

      f.input :client

      f.input :description, :input_html => { :rows => 10 }

      f.input :comment, :input_html => { :rows => 10 }

      f.input :state, as: :select, collection: {"Ouvert" => "Ouvert", "Fermé" => "Fermé"}, include_blank: false

      f.input :assigned_to

      f.input :duration

      f.input :recipients, hint: "Liste d'emails séparés par une virgule"

    end

    f.buttons

  end

end
