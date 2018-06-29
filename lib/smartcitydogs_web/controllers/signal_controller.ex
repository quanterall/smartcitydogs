defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataUser

  def index(conn, params) do
   # signal = DataSignals.list_signals()
   page = Signals |> Smartcitydogs.Repo.paginate(params)
   render(conn, "index_signal.html", signal: page.entries, page: page)
  end


  def new(conn, _params) do
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})
    render(conn, "new_signal.html", changeset: changeset)
  end

  def create(conn, %{"signals" => signal_params}) do
    a = conn.assigns.current_user.id

    signal_params =
      signal_params
      |> Map.put("signals_types_id", 1)
      |> Map.put("view_count", 1)
      |> Map.put("support_count", 0)
      |> Map.put("users_id", a)

    case DataSignals.create_signal(signal_params) do
      {:ok, signal} ->
        upload = Map.get(conn, :params)
        upload = Map.get(upload, "signals")
        upload = Map.get(upload, "url")
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

        redirect(conn, to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_signal.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comments = DataSignals.get_comment_signal_id(id)
    signal = DataSignals.get_signal(id)
    render(conn, "show_signal.html", signal: signal, comments: comments)
  end

  def edit(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    changeset = DataSignals.change_signal(signal)

    render(conn, "edit_signal.html", signal: signal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal = DataSignals.get_signal(id)

    case DataSignals.update_signal(signal, signal_params) do
      {:ok, signal} ->
        conn
        |> put_flash(:info, "Signal updated successfully.")
        |> render("show_signal.html", signal: signal)



      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    end
  end

  def get_signals_support_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)

    if list != [] do
      [head | tail] = list
      count = head.support_count
      Smartcitydogs.DataSignals.update_signal(head, %{support_count: count + 1})
    end

    head.support_count + 1
  end

  def update_like_count(conn, %{"show-count" => show_count, "show-id" => show_id}) do
    signal = DataSignals.get_signal(show_id)
    count = get_signals_support_count(show_id)
    conn
    |> json(%{new_count: count})
  end

  def comment(conn, %{"show-comment" => show_comment, "show-id" => show_id}) do
    user_id = conn.assigns.current_user.id

    Smartcitydogs.DataSignals.create_signal_comment(%{
      comment: show_comment,
      signals_id: show_id,
      users_id: user_id
    })

    # redirect conn, to: "/signals/#{show_id}"
    render("show_signal.html")
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _signal} = DataSignals.delete_signal(id)

    conn
    |> put_flash(:info, "Signal deleted successfully.")
    |> redirect(to: signal_path(conn, :index))
  end
end
