defmodule Smartcitydogs.Plugs.CheckStaff do
  import Phoenix.Controller
  import Plug.Conn
  def init(options), do: Map.new(options)

  def call(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    if Enum.member?(["police", "municipality", "shelter", "admin"], user.user_type) do
      conn
    else
      conn
      |> put_status(403)
      |> text("Permission deny!")
      |> halt()
    end
  end
end
