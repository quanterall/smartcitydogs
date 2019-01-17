defmodule SmartcitydogsWeb.ZooPolice.AnimalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Signal, Repo, SignalFilters}
  import Ecto.Query

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, params) do
  end
end
