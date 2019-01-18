# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :smartcitydogs, ecto_repos: [Smartcitydogs.Repo]

# Configures the endpoint
config :smartcitydogs, SmartcitydogsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wK4igjlEwIrLAGaNDlb5RiqrfX1N/5/TwBhr61oVhKDS8du1WZE2unzbBuVAd6HF",
  render_errors: [view: SmartcitydogsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Smartcitydogs.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# RECAPTCHA
config :recaptcha,
  public_key: {:system, "6LeC1mkUAAAAAEX_aVOwFFByXgT3FNnMLnfdR0gf"},
  secret: {:system, "6LeC1mkUAAAAAEaLMesIocRsy2oKwHHZZJjv3dA3"}

config :guardian, Guardian,
  issuer: "SimpleAuth.#{Mix.env()}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Smartcitydogs.GuardianSerializer,
  secret_key: to_string(Mix.env()) <> "SuPerseCret_aBraCadabrA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# In your config file
config :smartcitydogs, Smartcitydogs.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SES_SERVER"),
  ## hostname: System.get_env("SES_HOSTNAME"),
  port: System.get_env("SES_PORT"),
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  # can be `:always` or `:never`
  tls: :if_available,
  # can be `true`
  ssl: false,
  retries: 4

config :smartcitydogs,
  show_deleted_content: false

config :scrivener_html,
  routes_helper: MyApp.Router.Helpers,
  # If you use a single view style everywhere, you can configure it here. See View Styles below for more info.
  view_style: :bootstrap_v4

config :ueberauth, Ueberauth,
  providers: [
    facebook: {Ueberauth.Strategy.Facebook, []}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_ID"),
  client_secret: System.get_env("FACEBOOK_SECRET")
