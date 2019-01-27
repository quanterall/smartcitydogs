defmodule Smartcitydogs.Plugs.AssignCurrentUser do
  import Plug.Conn
  require Logger

  def init(default), do: default

  def call(conn, _) do
    assign(conn, :current_user, Guardian.Plug.current_resource(conn))
  end
end
