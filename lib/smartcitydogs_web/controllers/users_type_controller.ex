defmodule SmartCityDogsWeb.UsersTypeController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.UsersTypes
  alias SmartCityDogs.UsersTypes.UsersType

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    users_types = UsersTypes.list_users_types()
    render(conn, "index.json", users_types: users_types)
  end

  def create(conn, %{"users_type" => users_type_params}) do
    with {:ok, %UsersType{} = users_type} <- UsersTypes.create_users_type(users_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", users_type_path(conn, :show, users_type))
      |> render("show.json", users_type: users_type)
    end
  end

  def show(conn, %{"id" => id}) do
    users_type = UsersTypes.get_users_type!(id)
    render(conn, "show.json", users_type: users_type)
  end

  def update(conn, %{"id" => id, "users_type" => users_type_params}) do
    users_type = UsersTypes.get_users_type!(id)

    with {:ok, %UsersType{} = users_type} <-
           UsersTypes.update_users_type(users_type, users_type_params) do
      render(conn, "show.json", users_type: users_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    users_type = UsersTypes.get_users_type!(id)

    with {:ok, %UsersType{}} <- UsersTypes.delete_users_type(users_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
