# encoding: UTF-8

ActiveAdmin.register MaintenanceTicket do

  form do |f|
    f.inputs do

      f.input :maintained_by, as: :select, collection:
      {
        "Téléphone" => "Téléphone",
        "Prise de main" => "Prise de main",
        "Sur site" => "Sur site"
        }, include_blank: false

      f.input :client_name

      f.input :client_email

      f.input :comment

      f.input :state, as: :select, collection: {"Ouvert" => "Ouvert", "Fermé" => "Fermé"}, include_blank: false

    end

    f.buttons

  end

end
