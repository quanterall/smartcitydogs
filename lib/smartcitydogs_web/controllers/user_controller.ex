defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  def index(conn, _params) do
    render(conn, "user.html")
  end
end
