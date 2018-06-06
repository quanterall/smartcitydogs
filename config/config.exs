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

config :guardian, Guardian,
  issuer: "SimpleAuth.#{Mix.env()}",
  ttl: {30, :days},
  verify_issuer: true,
  serializer: Smartcitydogs.GuardianSerializer,
  secret_key: to_string(Mix.env()) <> "SuPerseCret_aBraCadabrA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
