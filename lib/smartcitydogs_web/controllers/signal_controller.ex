defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.Repo
  import Ecto.Query

  action_fallback(SmartCityDogsWeb.FallbackController)

  ## Hanlde regular user page
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
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Signals.Policy,
             :new,
             conn.assigns.current_user
           ) do
      render(conn, "new_signal.html", changeset: changeset)
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def create(conn, signal_params) do
    a = conn.assigns.current_user.id

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Signals.Policy,
             :create,
             conn.assigns.current_user
           ) do
      signal_params =
        signal_params
        |> Map.put("signals_types_id", 1)
        |> Map.put("view_count", 0)
        |> Map.put("support_count", 0)
        |> Map.put("users_id", a)

      case DataSignals.create_signal(signal_params) do
        {:ok, signal} ->
          upload = Map.get(conn, :params)

          upload = Map.get(upload, "url")

          if upload == nil do
          else
            for n <- upload do
              extension = Path.extname(n.filename)

              File.cp(
                n.path,
                "../smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{
                  extension
                }"
              )

              args = %{
                "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
                "signals_id" => "#{signal.id}"
              }

              DataSignals.create_signal_images(args)
            end
          end

          redirect(conn, to: signal_path(conn, :show, signal))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new_signal.html", changeset: changeset)
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def show(conn, params) do
    signal =
      Signals
      |> Repo.get(params["id"])
      |> Repo.preload([:signals_types, :signals_categories, :signals_likes, :signals_images])
      |> Repo.preload([:signals_comments, signals_comments: :users])

    render(
      conn,
      "show.html",
      signal: signal
    )
  end

  def edit(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Signals.Policy,
             :edit,
             conn.assigns.current_user
           ) do
      changeset = DataSignals.change_signal(signal)
      render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal = DataSignals.get_signal(id)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Signals.Policy,
             :update,
             conn.assigns.current_user
           ) do
      case DataSignals.update_signal(signal, signal_params) do
        {:ok, signal} ->
          conn
          |> put_flash(:info, "Signal updated successfully.")
          |> render("show.html", signal: signal)

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit_signal.html", signal: signal, changeset: changeset)
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
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
    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Signals.Policy,
             :update,
             conn.assigns.current_user
           ) do
      {:ok, _} = DataSignals.delete_signal(id)

      conn
      |> put_flash(:info, "Signal deleted successfully.")
      |> redirect(to: signal_path(conn, :index))
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end
end
