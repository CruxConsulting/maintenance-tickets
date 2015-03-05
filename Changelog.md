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
