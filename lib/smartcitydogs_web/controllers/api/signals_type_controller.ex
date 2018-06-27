defmodule SmartcitydogsWeb.SignalsTypeControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalsTypes
  alias Smartcitydogs.DataSignals

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signals_types = DataSignals.list_signal_types()
    render(conn, "index.json", signals_types: signals_types)
  end

  def create(conn, %{"signals_type" => signals_type_params}) do
    with {:ok, %SignalsTypes{} = signals_type} <-
      DataSignals.create_signal_type(signals_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signals_type_controller_api_path(conn, :show, signals_type))
      |> render("show.json", signals_type: signals_type)
    end
  end

  def show(conn, %{"id" => id}) do
    signals_type = DataSignals.get_signal_type(id)
    render(conn, "show.json", signals_type: signals_type)
  end

  def update(conn, %{"id" => id, "signals_type" => signals_type_params}) do
    signals_type = DataSignals.get_signal_type(id)

    with {:ok, %SignalsTypes{} = signals_type} <-
      DataSignals.update_signal_type(signals_type, signals_type_params) do
      render(conn, "show.json", signals_type: signals_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalsTypes{}} <- DataSignals.delete_signal_type(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
