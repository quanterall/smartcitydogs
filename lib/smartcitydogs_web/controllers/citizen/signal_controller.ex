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
          SignalsImages.insert_images(signal, params["url"])
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
    |> redirect(to: signal_path(conn, :show, id))
  end

  def dislike(conn, %{"id" => id}) do
    Signals.remove_like(conn.assigns.current_user.id, id)
    redirect(conn, to: signal_path(conn, :show, id))
  end
end
