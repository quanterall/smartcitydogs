defmodule SmartcitydogsWeb.Admin.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.User

  def index(conn, _params) do
    users = Smartcitydogs.DataUsers.list_users

    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Smartcitydogs.DataUsers.get_user!(id)

    render(conn, "show.html", user: user)
  end
end
