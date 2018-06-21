defmodule SmartCityDogsWeb.SignalController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.Signals
  alias SmartCityDogs.Signals.Signal

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    signals = Signals.list_signals()
    render(conn, "index.json", signals: signals)
  end

  def create(conn, %{"signal" => signal_params}) do
    with {:ok, %Signal{} = signal} <- Signals.create_signal(signal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_path(conn, :show, signal))
      |> render("show.json", signal: signal)
    end
  end

  def show(conn, %{"id" => id}) do
    signal = Signals.get_signal!(id)
    render(conn, "show.json", signal: signal)
  end

  def update(conn, %{"id" => id, "signal" => signal_params}) do
    signal = Signals.get_signal!(id)

    with {:ok, %Signal{} = signal} <- Signals.update_signal(signal, signal_params) do
      render(conn, "show.json", signal: signal)
    end
  end

  def delete(conn, %{"id" => id}) do
    signal = Signals.get_signal!(id)

    with {:ok, %Signal{}} <- Signals.delete_signal(signal) do
      send_resp(conn, :no_content, "")
    end
  end
end
