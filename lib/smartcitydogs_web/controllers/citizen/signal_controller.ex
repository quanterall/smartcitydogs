defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignal
  alias Smartcitydogs.Signal
  alias Smartcitydogs.Repo
  alias Smartcitydogs.SignalComment
  alias Smartcitydogs.SignalImages
  alias Smartcitydogs.DataUsers
  import Ecto.Query

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, params) do
    page =
      Signal
      |> order_by(desc: :inserted_at)
      |> preload([:signal_type, :signal_category, :signal_comments, :signal_likes])
      |> Repo.paginate(params)

    render(conn, "index.html", signals: page.entries, page: page)
  end

  def new(conn, _params) do
    signal_changeset = Smartcitydogs.DataSignal.change_signal(%Signal{})
    render(conn, "new.html", signal_changeset: signal_changeset)
  end

  def create(%{:assigns => %{:current_user => %{:id => user_id}}} = conn, %{"signals" => params}) do
    params
    |> Map.put("user_id", user_id)

    case Signal.create_signal(params) do
      {:ok, signal} ->
        if params["url"] != nil do
          SignalImages.insert_images(signal, params["url"])
        end

        redirect(conn, to: signal_path(conn, :show, signal))

      {:error, signal_changeset} ->
        render(conn, "new.html", signal_changeset: signal_changeset)
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

  def edit(conn, %{"id" => id}) do
    signal = Signal |> Repo.get(id)
    signal_changeset = signal |> Signal.changeset(%{})
    render(conn, "edit.html", signal: signal, signal_changeset: signal_changeset)
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal =
      Signal
      |> Repo.get(id)

    result =
      Signal.changeset(signal, signal_params)
      |> Repo.update()

    case result do
      {:ok, signal} ->
        redirect(conn, to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = signal_changeset} ->
        render(conn, "edit.html", signal: signal, signal_changeset: signal_changeset)
    end
  end

  def update_type(conn, %{"id" => id, "signal_type_id" => signal_type_id}) do
    signal = DataSignal.get_signal(id)
    DataSignal.update_signal(signal, %{"signal_type_id" => signal_type_id})
    redirect(conn, to: signal_path(conn, :minicipality_signals))
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _} = Repo.get!(Signal, id) |> Repo.delete()

    conn
    |> put_flash(:info, "Signal deleted successfully.")
    |> redirect(to: signal_path(conn, :index))
  end

  def like(conn, %{"id" => id}) do
    Signal.add_like(conn.assigns.current_user.id, id)

    conn
    |> redirect(to: signal_path(conn, :show, id))
  end

  def dislike(conn, %{"id" => id}) do
    Signal.remove_like(conn.assigns.current_user.id, id)
    redirect(conn, to: signal_path(conn, :show, id))
  end
end
