defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.Signal
  alias Smartcitydogs.Repo
  alias Smartcitydogs.SignalComment
  alias Smartcitydogs.SignalFilter
  alias SmartcitydogsWeb.QueryFilter
  import Ecto.Query

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, params) do
    query =
      Signal
      |> order_by(desc: :inserted_at)
      |> preload([:signal_type, :signal_category, :signal_comments, :signal_likes])
      |> prepare_query_filters(params)

    pagination_params = [
      {:signal_filter,
       [
         {:signal_type_id, params["signal_filter"]["signal_type_id"]},
         {:signal_category_id, params["signal_filter"]["signal_category_id"]}
       ]}
    ]

    page = Repo.paginate(query, Map.merge(params, %{page_size: 6}))

    render(conn, "index.html",
      params: params,
      pagination_params: pagination_params,
      signals: page.entries,
      page: page,
      filter_changeset: get_filter_changeset(params)
    )
  end

  defp prepare_query_filters(query, %{"signal_filter" => params}) do
    QueryFilter.filter(query, params)
  end

  defp prepare_query_filters(query, %{}) do
    query
  end

  def get_filter_changeset(params) do
    if params["signal_filter"] != nil do
      SignalFilter.changeset(%SignalFilter{}, params["signal_filter"])
    else
      SignalFilter.changeset(%SignalFilter{}, %{})
    end
  end

  def show(conn, %{"id" => id}) do
    signal =
      Signal
      |> Repo.get(id)
      |> Repo.preload([
        :signal_type,
        :signal_category,
        :signal_likes,
        :signal_images,
        signal_comments: from(p in SignalComment, order_by: [desc: p.inserted_at]),
        signal_comments: :user
      ])

    signal
    |> Signal.changeset(%{view_count: signal.view_count + 1})
    |> Repo.update()

    user_likes_count =
      Signal.get_like_by_user(signal, conn.assigns.current_user)
      |> Enum.count()

    render(
      conn,
      "show.html",
      signal: signal,
      user_likes_count: user_likes_count
    )
  end
end
