defmodule SmartcitydogsWeb.Shelter.LayoutView do
  use SmartcitydogsWeb, :view

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end

  def printNavbar(conn, current_user) do
    render("navbar_shelter.html", %{conn: conn, current_user: current_user})
  end
end
