use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :smartcitydogs, SmartcitydogsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :smartcitydogs, Smartcitydogs.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("SMARTCITYDOGS_DB_USER"),
  password: System.get_env("SMARTCITYDOGS_DB_PASSWORD"),
  database: System.get_env("SMARTCITYDOGS_DB_NAME"),
  hostname: System.get_env("SMARTCITYDOGS_DB_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox
