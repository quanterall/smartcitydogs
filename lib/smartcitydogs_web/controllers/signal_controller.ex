defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.Repo
  alias Smartcitydogs.SignalsComments
  alias Smartcitydogs.SignalsImages
  alias Smartcitydogs.DataUsers
  import Ecto.Query

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, params) do
    page =
      Signals
      |> order_by(desc: :inserted_at)
      |> preload([:signals_types, :signals_categories, :signals_comments, :signals_likes])
      |> Repo.paginate(params)

    render(conn, "index.html", signals: page.entries, page: page)
  end

  # All signals page with the checkbox filters, function for the first rendering
  def minicipality_signals(conn, params) do
    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Signals.Policy,
             :minicipality_signals,
             conn.assigns.current_user
           ) do
      data_status =
        case Map.fetch(params, "page") do
          {:ok, num} -> {params["data_status"], params["data_category"], num}
          _ -> {[], [], "1"}
        end

      [page, data_category, data_status] = Signals.get_ticked_checkboxes(data_status)

      render(conn, "minicipality_signals.html",
        signal: page.entries,
        page: page,
        data_category: data_category,
        data_status: data_status
      )
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  ## When the search button is clicked, for rendering the first page of the query.
  def filter_signals(conn, %{
        "_utf8" => "✓",
        "sig_category" => data_category,
        "sig_status" => data_status
      }) do
    data_status = Enum.filter(data_status, fn x -> x != "false" end)
    data_category = Enum.filter(data_category, fn x -> x != "false" end)

    cond do
      data_status != [] ->
        all_query = []

        all_query =
          Enum.map(data_status, fn x ->
            struct = from(p in Signals, where: p.signals_types_id == ^String.to_integer(x))
            all_query ++ Repo.all(struct)
          end)

        page = Smartcitydogs.Repo.paginate(List.flatten(all_query), page: 1, page_size: 9)

        render(conn, "minicipality_signals.html",
          signal: page.entries,
          page: page,
          data_status: data_status,
          data_category: data_category
        )

      data_category != [] ->
        all_query = []

        all_query =
          Enum.map(data_category, fn x ->
            struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))
            all_query ++ Repo.all(struct)
          end)

        all_query = List.flatten(all_query)
        page = Smartcitydogs.Repo.paginate(all_query, page: 1, page_size: 9)

        render(conn, "minicipality_signals.html",
          signal: page.entries,
          page: page,
          data_category: data_category,
          data_status: data_status
        )

      true ->
        all_query = DataSignals.list_signals()
        page = Smartcitydogs.Repo.paginate(all_query, page: 1, page_size: 9)

        render(conn, "minicipality_signals.html",
          signal: page.entries,
          page: page,
          data_status: data_status,
          data_category: data_category
        )
    end
  end

  def new(conn, _params) do
    signal_changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})
    render(conn, "new.html", signal_changeset: signal_changeset)
  end

  def create(%{:assigns => %{:current_user => %{:id => user_id}}} = conn, %{"signals" => params}) do
    params
    |> Map.put("users_id", user_id)

    case Signals.create_signal(params) do
      {:ok, signal} ->
        if params["url"] != nil do
          for n <- params["url"] do
            extension = Path.extname(n.filename)

            File.cp(
              n.path,
              "../smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{extension}"
            )

            signal_image_params = %{
              "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
              "signals_id" => "#{signal.id}"
            }

            %SignalsImages{}
            |> SignalsImages.changeset(signal_image_params)
            |> Repo.insert()
          end
        end

        redirect(conn, to: signal_path(conn, :show, signal))

      {:error, signal_changeset} ->
        render(conn, "new.html", signal_changeset: signal_changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    signal =
      Signals
      |> Repo.get(id)
      |> Repo.preload([
        :signals_types,
        :signals_categories,
        :signals_likes,
        :signals_images,
        signals_comments: from(p in SignalsComments, order_by: [desc: p.inserted_at]),
        signals_comments: :users
      ])

    signal
    |> Signals.changeset(%{view_count: signal.view_count + 1})
    |> Repo.update()

    user_likes_count =
      Signals.get_like_by_user(signal, conn.assigns.current_user)
      |> Enum.count()

    render(
      conn,
      "show.html",
      signal: signal,
      user_likes_count: user_likes_count
    )
  end

  def edit(conn, %{"id" => id}) do
    signal = Signals |> Repo.get(id)
    signal_changeset = signal |> Signals.changeset(%{})
    render(conn, "edit.html", signal: signal, signal_changeset: signal_changeset)
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal =
      Signals
      |> Repo.get(id)

    result =
      Signals.changeset(signal, signal_params)
      |> Repo.update()

    case result do
      {:ok, signal} ->
        redirect(conn, to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = signal_changeset} ->
        render(conn, "edit.html", signal: signal, signal_changeset: signal_changeset)
    end
  end

  def followed_signals(conn, _) do
    {page} = Signals.get_button_signals(conn.assigns.current_user.id)
    render(conn, "followed_signals.html", signals: page.entries, page: page)
  end

  def update_type(conn, %{"id" => id, "signals_types_id" => signals_types_id}) do
    signal = DataSignals.get_signal(id)
    DataSignals.update_signal(signal, %{"signals_types_id" => signals_types_id})
    redirect(conn, to: signal_path(conn, :minicipality_signals))
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _} = Repo.get!(Signals, id) |> Repo.delete()

    conn
    |> put_flash(:info, "Signal deleted successfully.")
    |> redirect(to: signal_path(conn, :index))
  end

  def like(conn, %{"id" => id}) do
    Signals.add_like(conn.assigns.current_user.id, id)

    conn
    |> put_flash(:info, "Signal liked!")
    |> redirect(to: signal_path(conn, :show, id))
  end

  def dislike(conn, %{"id" => id}) do
    Signals.remove_like(conn.assigns.current_user.id, id)
    redirect(conn, to: signal_path(conn, :show, id))
  end
end
