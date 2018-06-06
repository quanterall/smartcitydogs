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

    # IO.puts "#{inspect(signal_params)}"

    case DataSignals.create_signal(signal_params) do
      {:ok, signal} ->
        conn
        |> put_flash(:info, "Signal created successfully.")
        |> redirect(to: signal_path(conn, :show, signal))

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
    # IO.puts "#{inspect(signal)}"
    # IO.puts "#{inspect(signal)}"
    case DataSignals.update_signal(signal, signal_params) do
      {:ok, signal} ->
        conn
        |> put_flash(:info, "Signal updated successfully.")
        |> redirect(to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    # signal = DataSignals.get_signal(id)
    # IO.puts "#{inspect(id)}"
    # IO.puts "#{inspect(signal)}"
    {:ok, _signal} = DataSignals.delete_signal(id)

    conn
    |> put_flash(:info, "Signal deleted successfully.")
    |> redirect(to: signal_path(conn, :index))
  end
end
