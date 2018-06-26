defmodule SmartcitydogsWeb.SignalControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataSignals

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signals = DataSignals.list_signals()
    render(conn, "index.json", signals: signals)
  end

  def create(conn, %{"signal" => signal_params}) do
   ## IO.inspect(signal_params)

    with {:ok, %Signals{} = signal} <- DataSignals.create_signal(signal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_path(conn, :show, signal))
      |> render("show.json", signal: signal)
    end
  end

  def show(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    render(conn, "show.json", signal: signal)
  end

  def update(conn, %{"id" => id, "signal" => signal_params}) do
    signal = DataSignals.get_signal(id)

    with {:ok, %Signals{} = signal} <- DataSignals.update_signal(signal, signal_params) do
      render(conn, "show.json", signal: signal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Signals{}} <- DataSignals.delete_signal(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
