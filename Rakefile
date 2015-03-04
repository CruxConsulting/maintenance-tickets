#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

AdminAsconseilEu::Application.load_tasks

desc "Loads the clients from the xls file in vendor/asconseil/clients.xls"
task :load_clients => [:environment] do
  uri = "File://" + (Rails.root + "vendor/asconseil/clients.xls").to_s

  t = RemoteTable.new uri
  t.rows.each do |r|
    Client.find_or_create_by_name name: r["name"], email: r["email"]
  end
end

desc "Send reminder email when assets are about to expire"
task :send_assets_expire_soone_reminder => [:environment] do |task, args|
  AdminMailer.assets_expire_soon.deliver_now
end
