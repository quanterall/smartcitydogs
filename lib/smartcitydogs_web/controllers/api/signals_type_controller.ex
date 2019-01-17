defmodule SmartcitydogsWeb.SignalTypeControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalTypes
  alias Smartcitydogs.DataSignal

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signal_type = DataSignal.list_signal_types()
    render(conn, "index.json", signal_type: signal_type)
  end

  def create(conn, %{"signal_type" => signal_type_params}) do
    with {:ok, %SignalTypes{} = signal_type} <-
           DataSignal.create_signal_type(signal_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_type_controller_api_path(conn, :show, signal_type))
      |> render("show.json", signal_type: signal_type)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_type = DataSignal.get_signal_type(id)
    render(conn, "show.json", signal_type: signal_type)
  end

  def update(conn, %{"id" => id, "signal_type" => signal_type_params}) do
    signal_type = DataSignal.get_signal_type(id)

    with {:ok, %SignalTypes{} = signal_type} <-
           DataSignal.update_signal_type(signal_type, signal_type_params) do
      render(conn, "show.json", signal_type: signal_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalTypes{}} <- DataSignal.delete_signal_type(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
