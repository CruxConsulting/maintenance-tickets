AdminAsconseilEu::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => redirect("/admin/maintenance_tickets")

end
