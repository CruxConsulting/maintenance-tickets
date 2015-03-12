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
