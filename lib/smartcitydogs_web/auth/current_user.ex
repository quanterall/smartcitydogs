defmodule Smartcitydogs.CurrentUser do
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = current_resource(conn)
    assign(conn, :current_user, current_user)
    # if(current_user == nil){
    #   redirect(conn, to: session_path(Endpoint, :login))
    # }
  end
end
