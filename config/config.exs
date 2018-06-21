# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :smartcitydogs,
  namespace: SmartCityDogs,
  ecto_repos: [SmartCityDogs.Repo]

# Configures the endpoint
config :smartcitydogs, SmartCityDogsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JToVszmUmy4FiPsPYn5cQHmxxfu8GTTNsMyRJm30v7IhDV/AhIvFQ9zVm7KmRtBo",
  render_errors: [view: SmartCityDogsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SmartCityDogs.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
# In your config file

config :smartcitydogs, SmartCityDogs.Mailer,
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
