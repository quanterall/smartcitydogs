defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals

  def index(conn, _params) do
    signal = DataSignals.list_signals()
    render(conn, "index_signal.html", signal: signal)
  end

  def new(conn, _params) do
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})
    render(conn, "new_signal.html", changeset: changeset)
  end

  def create(conn, %{"signals" => signal_params}) do
    signal_params =
      signal_params
      |> Map.put("signals_types_id", 1)
      |> Map.put("view_count", 1)
      |> Map.put("support_count", 1)

    case DataSignals.create_signal(signal_params) do
      {:ok, signal} ->
        upload = Map.get(conn, :params)
       #IO.inspect(upload)
       upload = Map.get(upload, "signals")
       #IO.inspect(upload)
       upload = Map.get(upload, "url")
       #IO.inspect(upload)
       for n <- upload do
           #[head] = n
           IO.puts "\n N:"
           IO.inspect(n)

           extension = Path.extname(n.filename)
           File.cp(n.path, "/home/hris/Elixir/smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{extension}")
           args = %{"url" => "images/#{Map.get(n, :filename)}-profile#{extension}", "signals_id" => "#{signal.id}"}
           DataSignals.create_signal_images(args)
       end

        redirect(conn, to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_signal.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    render(conn, "show_signal.html", signal: signal)
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
        #redirect(to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    end
  end

  def get_signals_support_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)
    if list != [] do
      [head | tail] = list
      count = head.support_count
       IO.puts "---------------------------------------"
       IO.inspect(count)
       IO.puts "------------------------------------------"
       Smartcitydogs.DataSignals.update_signal(head,%{support_count: count+1})
       IO.puts "_________________________________________________"
       IO.inspect(head.support_count)
       IO.puts "_________________________________________________"
    end
    head.support_count + 1
  end

  def update_like_count(conn, %{"show-count" => show_count, "show-id" => show_id}) do#, "show-id" => show_id}) do
    IO.inspect(show_count, pretty: true)
    IO.inspect(show_id, pretty: true)
    signal = DataSignals.get_signal(show_id)
    count = get_signals_support_count(show_id)
    IO.puts "_________________________________________________"
    IO.inspect(count)
    IO.puts "_________________________________________________"

    conn
    |> json(%{new_count: count})
    #redirect(conn, to: signal_path(conn, :show, signal))
    #|> render("show_signal.html", show_id: show_id)

  end


  def delete(conn, %{"id" => id}) do
    {:ok, _signal} = DataSignals.delete_signal(id)

    conn
    |> put_flash(:info, "Signal deleted successfully.")
    |> redirect(to: signal_path(conn, :index))
  end
end
