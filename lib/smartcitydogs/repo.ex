defmodule Smartcitydogs.Repo do
  use Ecto.Repo,
    otp_app: :smartcitydogs,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 6
end
