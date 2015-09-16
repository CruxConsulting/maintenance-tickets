ActiveAdmin.register MaintenanceTicket do

  config.sort_order = 'state_desc'

  # Views
  #######

  index do
    column :id
    column :client
    column :maintained_by
    column :maintenance_date
    column :description
    column :comment
    column :state
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :maintained_by
      row :maintenance_date
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
      row :comment do |ticket|
        simple_format ticket.comment
      end
      row :confidential_info do |ticket|
        simple_format ticket.confidential_info
      end
      row :assigned_to do
        ticket_assigned_to_human(resource)
      end
      row :duration
      row :recipients
    end
  end

  form do |f|
    f.inputs do

      f.input :maintained_by,
              as: :select,
              collection: resource.class::MAINTAINED_BY,
              include_blank: false

      f.input :maintenance_date, as: :datepicker
      f.input :client
      f.input :description, input_html: { rows: 10 }
      f.input :comment, input_html: { rows: 10 }
      f.input :confidential_info, input_html: { rows: 10 }

      f.input :state,
              as: :select,
              collection: resource.class::STATES,
              include_blank: false

      f.input :assigned_to,
              as: :select,
              input_html: {multiple: true},
              collection: resource.class::TECH_PEOPLE,
              include_blank: false

      f.input :duration, as: :number, input_html: {step: 0.5}
      f.input :recipients, hint: "Liste d'emails séparés par une virgule"
    end

    f.actions

  end

  # Controller
  ############

  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_maintenance_tickets_url }
      end
    end
  end

end
