defmodule Smartcitydogs.CheckMunicipality do
  import Phoenix.Controller
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)

    if current_user.user_type_id == 4 do
      conn
    else
      conn
      |> put_status(:not_found)
      |> put_view(SmartcitydogsWeb.ErrorView)
      |> render( "404.html")
      |> halt
    end
  end
end
