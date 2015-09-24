ActiveAdmin.register Asset do

  actions :index, :destroy

  menu parent: 'Objets'

  filter :client
  filter :name
  filter :description
  filter :expiration_date

  index do
    column :client
    column :name
    column :expiration_date do |resource|
      l resource.expiration_date, format: :long
    end

    actions do |resource|
      link_to 'modifier', [:admin, resource], class: 'member_link'
    end
  end

end
