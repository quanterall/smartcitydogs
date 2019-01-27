defmodule SmartcitydogsWeb.LayoutView do
  use SmartcitydogsWeb, :view
  alias Smartcitydogs.Guardian

  def printNavbar(conn, current_user) do
    case Guardian.Plug.current_resource(conn) do
      %{user_type: "police"} ->
        render("navbar_zoo.html", %{conn: conn, current_user: current_user})

      %{user_type: "municipality"} ->
        render("navbar_municipality.html", %{conn: conn, current_user: current_user})

      %{user_type: "shelter"} ->
        render("navbar_shelter.html", %{conn: conn, current_user: current_user})

      _ ->
        render("navbar_default.html", %{conn: conn, current_user: current_user})
    end
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
