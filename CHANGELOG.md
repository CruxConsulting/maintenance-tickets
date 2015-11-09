1.3.9
-----

- allow server ordering by lastest_monthly_report_date
- new "without_monthly_report" model and admin scope on server_assets

1.3.8
-----

- display "Dernière VM" in ServerAsset's index
- add #lastest_montly_report and #lastest_montly_report_date to ServerAsset

1.3.7
-----

- set dev mailer host to admin-asconseil.lvh.me:5000
- use polymorphic_url in assets_expire_soon template

1.3.6
-----

- append an extra ' ' after last_backup_reason in PDF to avoid alignment issues

1.3.5
-----

- add "total_storage" to VM's PDF
- validate presence of expiration_date on assets
- use ldate on server assets index and show
- new ldate helper to handle nil dates

1.3.4
-----

- add missing keys in fr.yml
- add description to all assets forms and show

1.3.3
-----

- update send_montly_report email content
- remove 'quantity' from server_assets index

1.3.2
-----

- correct send vm email content
- rename ServerAsset.name from "Numéro de série" to "Nom du serveur"
- only add additional recipients to sogexfo VMs
- Revert "additional_recipients for VMs"

1.3.1
-----

- fix pdf mail attachment bug when using cloudinary
- typo

1.3.0 (VMs)
-----------

- ticket duration min 0 in admin
- All the VM stuff
- new disk model
- add STI to assets
- avoid n+1 queries in tickets index

1.2.0
-----

- localize ticket datepicker in french
- use the ticket's first tech visit card at the end of the email
- smaller width for duration field
- set a fixed width for the "assigned_to" field in the ticket form
- use ENV['ACTION_MAILER_DEFAULT_URL_HOST'] in prod
- fix select2 image assets in prod
- order assets in descending order in assets_expire_soon email
- Add action link "Renvoi de l'email" on tickets index
- use a number input with step 0.5 for ticket duration field
- multiple values for assigned to
- select for ticket.assigned_to field
- Set 'Ouvert - Urgent' as default state for tickets
- Add 'Ouvert - X' states to MaintenanceTicket::STATES
- Add 'confidential_info' to maintenance tickets show and edit
- Add 'comment' to maintenance tickets show
- Add 'Atelier' for MaintenanceTicket::MAINTAINED_BY
- Passenger 5.0.18
- Rails 4.2.4
- Ruby 2.2.3

1.1.3
-----

- back to default scope order(:name) for clients

1.1.2
-----

- remove client_id select2 in assets filter and input
- add asset desc in client show and assets index
- fix maintenance ticket creation bug (remove select2 input)

1.1.1
-----

- send_assets_expire_soon_reminder operates every monday

1.1.0
-----

- fix new client form

1.1.0.beta2
-----------

- remove qa env
- remove serve_static_assets config
- set log_level to :info in prod
- only send the assets expire_soon reminder if there are assets that will expire soon

1.1.0.beta1
-----------

- new send_assets_expire_soon_reminder rake task
- use AA_select2
- add assets
- ruby 2.2
- rails 4.2
- replace unicorn by raptor
