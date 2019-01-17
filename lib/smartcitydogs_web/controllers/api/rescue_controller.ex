defmodule SmartcitydogsWeb.RescueControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Rescue
  alias Smartcitydogs.DataProcedure

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    rescues = DataProcedure.list_rescues()
    render(conn, "index.json", rescues: rescues)
  end

  def create(conn, %{"rescue" => rescue_params}) do
    with {:ok, %Rescue{} = rescues} <- DataProcedure.create_rescues(rescue_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", rescue_controller_api_path(conn, :show, rescues))
      |> render("show.json", rescue: rescues)
    end
  end

  def show(conn, %{"id" => id}) do
    rescues = DataProcedure.get_rescues!(id)
    render(conn, "show.json", rescue: rescues)
  end

  def update(conn, %{"id" => id, "rescue" => rescue_params}) do
    rescues = DataProcedure.get_rescues!(id)

    with {:ok, %Rescue{} = rescues} <- DataProcedure.update_rescues(rescues, rescue_params) do
      render(conn, "show.json", rescue: rescues)
    end
  end

  def delete(conn, %{"id" => id}) do
    rescues = DataProcedure.get_rescues!(id)

    with {:ok, %Rescue{}} <- DataProcedure.delete_rescues(rescues) do
      send_resp(conn, :no_content, "")
    end
  end
end
