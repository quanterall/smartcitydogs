defmodule SmartCityDogsWeb.RescueController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.Rescues
  alias SmartCityDogs.Rescues.Rescue

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    rescues = Rescues.list_rescues()
    render(conn, "index.json", rescues: rescues)
  end

  def create(conn, %{"rescue" => rescue_params}) do
    with {:ok, %Rescue{} = rescues} <- Rescues.create_rescue(rescue_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", rescue_path(conn, :show, rescues))
      |> render("show.json", rescue: rescues)
    end
  end

  def show(conn, %{"id" => id}) do
    rescues= Rescues.get_rescue!(id)
    render(conn, "show.json", rescue: rescues)
  end

  def update(conn, %{"id" => id, "rescue" => rescue_params}) do
    rescues = Rescues.get_rescue!(id)

    with {:ok, %Rescue{} = rescues} <- Rescues.update_rescue(rescues, rescue_params) do
      render(conn, "show.json", rescue: rescues)
    end
  end

  def delete(conn, %{"id" => id}) do
    rescues = Rescues.get_rescue!(id)
    with {:ok, %Rescue{}} <- Rescues.delete_rescue(rescues) do
      send_resp(conn, :no_content, "")
    end
  end
end
