defmodule SmartcitydogsWeb.LayoutView do
  use SmartcitydogsWeb, :view


  def get_csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end

  def printNavbar(conn,current_user) do

    case current_user do
       nil ->  render("navbar_no_user.html", %{conn: conn, current_user: current_user});
     %{users_types_id: 1} ->
        render("navbar.html", %{conn: conn,current_user: current_user});
      %{users_types_id: 2} ->
        render("navbar.html", %{conn: conn,current_user: current_user});
      %{users_types_id: 3} ->
        render("navbar_zoo.html", %{conn: conn,current_user: current_user});
      %{users_types_id: 4} ->
        render("navbar_municipality.html", %{conn: conn,current_user: current_user});
      %{users_types_id: 5} ->
        render("navbar_shelter.html", %{conn: conn,current_user: current_user})
    end

  end
  

end
