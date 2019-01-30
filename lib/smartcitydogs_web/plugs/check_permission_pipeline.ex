defmodule Smartcitydogs.Plugs.CheckPermission do
  import Phoenix.Controller
  import Plug.Conn
  def init(options), do: Map.new(options)

  def call(conn, %{user_type: user_type}) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect(conn)

    if user.user_type == user_type do
      conn
    else
      conn
      |> put_status(403)
      |> text("Permission deny!")
      |> halt()
    end
  end
end
