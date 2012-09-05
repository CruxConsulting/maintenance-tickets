# encoding: UTF-8

ActiveAdmin.register MaintenanceTicket do

  index do
    column :client
    column :maintained_by
    column :description
    column :comment
    column :state
    column :created_at
    default_actions
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

    end

    f.buttons

  end

end
