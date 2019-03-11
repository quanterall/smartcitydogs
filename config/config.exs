# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :smartcitydogs,
  ecto_repos: [Smartcitydogs.Repo]

# Configures the endpoint
config :smartcitydogs, SmartcitydogsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U2TQR0UOG7pl1qDCM4GR6aysnHWGxXKlc8komJQSSPPguB+Ek06SXQ0IGKjRNnQN",
  render_errors: [view: SmartcitydogsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Smartcitydogs.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :smartcitydogs, Smartcitydogs.Guardian,
  issuer: "Smartcitydogs",
  secret_key: "aSfdTO9toyeHzWw4yKF+sjDzu6LDX0FCy+Wa34A0AEYd+zNB9sXu7Sv+Z9REyI2Q",
  serializer: Smartcitydogs.GuardianSerializer

config :scrivener_html,
  routes_helper: Smartcitydogs.Router.Helpers,
  # If you use a single view style everywhere, you can configure it here. See View Styles below for more info.
  view_style: :bootstrap_v4

config :recaptcha,
  public_key: System.get_env("SMARTCITYDOGS_RECAPCHA_PUBLIC"),
  secret: System.get_env("SMARTCITYDOGS_RECAPCHA_SECRET")

config :smartcitydogs, Smartcitydogs.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("SMARTCITYDOGS_SES_SERVER"),
  port: System.get_env("SES_PORT"),
  username: System.get_env("SMARTCITYDOGS_SMTP_USERNAME"),
  password: System.get_env("SMARTCITYDOGS_SMTP_PASSWORD"),
  # can be `:always` or `:never`
  tls: :if_available,
  # can be `true`
  ssl: false,
  retries: 1

config :smartcitydogs,
  contact_email:
    System.get_env("SMARTCITYDOGS_CONTACT_EMAIL") ||
      "default_contact_email_smartcitydogs@gmail.com",
  secret_salt: System.get_env("SECRET_SALT") || "kdjfaiowefpaiwehgpa9w38thap8gfap;eiwsh",
  blockchain_secret: System.get_env("SMARTCITYDOGS_BLOCKCHAIN_SECRET"),
  blockchain_url:
    System.get_env("SMARTCITYDOGS_BLOCKCHAIN_URL") || "http://localhost:8000/entries"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
