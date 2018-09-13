defmodule SmartcitydogsWeb.ZooPolice.LayoutView do
  use SmartcitydogsWeb, :view

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end

  def printNavbar(conn, current_user) do
    render("navbar_municipality.html", %{conn: conn, current_user: current_user})
  end
end
