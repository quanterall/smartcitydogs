defmodule SmartcitydogsWeb.ZooPolice.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Signals, Repo, SignalsFilters}
  import Ecto.Query

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, params) do
    page =
      Signals
      |> order_by(desc: :inserted_at)
      |> preload([:signal_type, :signal_category, :signal_comments, :signal_likes])

    filter_changeset =
      if params["signals_filters"] != nil do
        SignalsFilters.changeset(%SignalsFilters{}, params["signals_filters"])
      else
        SignalsFilters.changeset(%SignalsFilters{}, %{})
      end

    page =
      if params["signals_filters"]["signal_type_id"] do
        page |> where([p], p.signal_type_id in ^params["signals_filters"]["signal_type_id"])
      else
        page
      end

    page =
      if params["signals_filters"]["signal_category_id"] do
        page
        |> where(
          [p],
          p.signal_category_id in ^params["signals_filters"]["signal_category_id"]
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
