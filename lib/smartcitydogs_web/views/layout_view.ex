defmodule SmartcitydogsWeb.LayoutView do
  use SmartcitydogsWeb, :view

  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end

  def printNavbar(conn, current_user) do
    case current_user do
      %{users_types_id: 3} ->
        render("navbar_zoo.html", %{conn: conn, current_user: current_user})

      %{users_types_id: 4} ->
        render("navbar_municipality.html", %{conn: conn, current_user: current_user})

      %{users_types_id: 5} ->
        render("navbar_shelter.html", %{conn: conn, current_user: current_user})

      _ ->
        render("navbar_default.html", %{conn: conn, current_user: current_user})
    end
  end
end
