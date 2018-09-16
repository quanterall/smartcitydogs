defmodule Smartcitydogs.CheckMunicipality do
  import Phoenix.Controller
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)

    if current_user.users_types_id == 4 do
      conn
    else
      conn
      |> put_status(:not_found)
      |> render(SmartcitydogsWeb.ErrorView, "404.html")
      |> halt
    end
  end
end