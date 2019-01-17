defmodule SmartcitydogsWeb.ZooPolice.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Signal, Repo, SignalFilters}
  import Ecto.Query

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, params) do
    page =
      Signal
      |> order_by(desc: :inserted_at)
      |> preload([:signal_type, :signal_category, :signal_comments, :signal_likes])

    filter_changeset =
      if params["signal_filters"] != nil do
        SignalFilters.changeset(%SignalFilters{}, params["signal_filters"])
      else
        SignalFilters.changeset(%SignalFilters{}, %{})
      end

    page =
      if params["signal_filters"]["signal_type_id"] do
        page |> where([p], p.signal_type_id in ^params["signal_filters"]["signal_type_id"])
      else
        page
      end

    page =
      if params["signal_filters"]["signal_category_id"] do
        page
        |> where(
          [p],
          p.signal_category_id in ^params["signal_filters"]["signal_category_id"]
        )
      else
        page
      end

    page = Repo.paginate(page, params)

    render(conn, "index.html",
      params: params,
      signals: page.entries,
      page: page,
      filter_changeset: filter_changeset
    )
  end
end
