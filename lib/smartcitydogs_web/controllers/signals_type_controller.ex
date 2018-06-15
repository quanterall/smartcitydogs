defmodule SmartCityDogsWeb.SignalsTypeController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.SignalsTypes
  alias SmartCityDogs.SignalsTypes.SignalsType

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    signals_types = SignalsTypes.list_signals_types()
    render(conn, "index.json", signals_types: signals_types)
  end

  def create(conn, %{"signals_type" => signals_type_params}) do
    with {:ok, %SignalsType{} = signals_type} <- SignalsTypes.create_signals_type(signals_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signals_type_path(conn, :show, signals_type))
      |> render("show.json", signals_type: signals_type)
    end
  end

  def show(conn, %{"id" => id}) do
    signals_type = SignalsTypes.get_signals_type!(id)
    render(conn, "show.json", signals_type: signals_type)
  end

  def update(conn, %{"id" => id, "signals_type" => signals_type_params}) do
    signals_type = SignalsTypes.get_signals_type!(id)

    with {:ok, %SignalsType{} = signals_type} <- SignalsTypes.update_signals_type(signals_type, signals_type_params) do
      render(conn, "show.json", signals_type: signals_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    signals_type = SignalsTypes.get_signals_type!(id)
    with {:ok, %SignalsType{}} <- SignalsTypes.delete_signals_type(signals_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
