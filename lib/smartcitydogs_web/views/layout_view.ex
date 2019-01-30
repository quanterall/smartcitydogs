defmodule SmartcitydogsWeb.LayoutView do
  use SmartcitydogsWeb, :view
  alias Smartcitydogs.Guardian

  def printNavbar(conn) do
    case Guardian.Plug.current_resource(conn) do
      %{user_type: "police"} ->
        render("navbar_zoo.html", %{conn: conn})

      %{user_type: "municipality"} ->
        render("navbar_municipality.html", %{conn: conn})

      %{user_type: "shelter"} ->
        render("navbar_shelter.html", %{conn: conn})

      _ ->
        render("navbar_default.html", %{conn: conn})
    end
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
