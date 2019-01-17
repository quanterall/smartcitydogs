defmodule Smartcitydogs.CheckPolice do
  import Phoenix.Controller
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)

    if current_user.user_type_id == 3 do
      conn
    else
      conn
      |> put_status(:not_found)
      |> render(SmartcitydogsWeb.ErrorView, "404.html")
      |> halt
    end
  end
end
