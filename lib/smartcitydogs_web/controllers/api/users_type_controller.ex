defmodule SmartcitydogsWeb.UsersTypeControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    users_types = DataUsers.list_users_types()
    render(conn, "index.json", users_types: users_types)
  end

  def show(conn, %{"id" => id}) do
    users_type = DataUsers.get_user_type(id)
    render(conn, "show.json", users_type: users_type)
  end
end
