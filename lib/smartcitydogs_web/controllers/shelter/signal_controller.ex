defmodule SmartcitydogsWeb.Shelter.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Signal, Repo, SignalFilter}
  import Ecto.Query

  def index(conn, params) do
    signals =
      Signal
      |> order_by(desc: :inserted_at)
      |> preload([:signal_type, :signal_category, :signal_comments, :signal_likes])

    filter_changeset =
      if params["signal_filter"] != nil do
        SignalFilter.changeset(%SignalFilter{}, params["signal_filter"])
      else
        SignalFilter.changeset(%SignalFilter{}, %{})
      end

    signals =
      if params["signal_filter"]["signal_type_id"] do
        signals |> where([p], p.signal_type_id in ^params["signal_filter"]["signal_type_id"])
      else
        signals
      end

    signals =
      if params["signal_filter"]["signal_category_id"] do
        signals
        |> where(
          [p],
          p.signal_category_id in ^params["signal_filter"]["signal_category_id"]
        )
      else
        signals
      end

    page = Repo.paginate(signals, params)

    render(conn, "index.html",
      params: params,
      signals: page.entries,
      page: page,
      filter_changeset: filter_changeset
    )
  end
end
