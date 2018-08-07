defmodule SmartcitydogsWeb.LayoutView do
  use SmartcitydogsWeb, :view


  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end


  

end
