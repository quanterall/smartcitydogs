defmodule SmartcitydogsWeb.LayoutView do
  use SmartcitydogsWeb, :view

  def printNavbar(conn, current_user) do
    case current_user do
      %{user_type_id: 3} ->
        render("navbar_zoo.html", %{conn: conn, current_user: current_user})

      %{user_type_id: 4} ->
        render("navbar_municipality.html", %{conn: conn, current_user: current_user})

      %{user_type_id: 5} ->
        render("navbar_shelter.html", %{conn: conn, current_user: current_user})

      _ ->
        render("navbar_default.html", %{conn: conn, current_user: current_user})
    end
  end
end
