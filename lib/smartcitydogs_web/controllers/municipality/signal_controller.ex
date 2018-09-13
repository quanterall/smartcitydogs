defmodule SmartcitydogsWeb.Municipality.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Signals, Repo, SignalsFilters}
  import Ecto.Query

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, params) do
    page =
      Signals
      |> order_by(desc: :inserted_at)
      |> preload([:signals_types, :signals_categories, :signals_comments, :signals_likes])

    filter_changeset =
      if params["signals_filters"] != nil do
        SignalsFilters.changeset(%SignalsFilters{}, params["signals_filters"])
      else
        SignalsFilters.changeset(%SignalsFilters{}, %{})
      end

    page =
      if params["signals_filters"]["signals_types_id"] &&
           params["signals_filters"]["signals_types_id"] != "" do
        page |> where([p], p.signals_types_id == ^params["signals_filters"]["signals_types_id"])
      else
        page
      end

    page =
      if params["signals_filters"]["signals_categories_id"] &&
           params["signals_filters"]["signals_categories_id"] != "" do
        page
        |> where(
          [p],
          p.signals_categories_id == ^params["signals_filters"]["signals_categories_id"]
        )
      else
        page
      end

    pagination_params = [
      {:signals_filters,
       [
         {:signals_types_id, params["signals_filters"]["signals_types_id"]},
         {:signals_categories_id, params["signals_filters"]["signals_categories_id"]}
       ]}
    ]

    page = Repo.paginate(page, params)

    render(conn, "index.html",
      params: params,
      pagination_params: pagination_params,
      signals: page.entries,
      page: page,
      filter_changeset: filter_changeset
    )
  end
end
