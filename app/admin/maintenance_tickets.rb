# encoding: UTF-8

ActiveAdmin.register MaintenanceTicket do

  form do |f|
    f.inputs do

      f.input :maintained_by, as: :select, collection:
      {
        "Téléphone" => :phone,
        "Prise de main" => :remote,
        "Sur site" => "on-site"
        }, include_blank: false

      f.input :client_name

      f.input :comment

      f.input :state, as: :select, collection: {"Ouvert" => :open, "Fermé" => :closed}, include_blank: false

    end

    f.buttons

  end

end
