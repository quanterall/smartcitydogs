defmodule Smartcitydogs.GuardianErrorHandler do
  import SmartcitydogsWeb.Router.Helpers

  def unauthenticated(conn, _params) do
    conn
    |> Phoenix.Controller.put_flash(:error, "You must be signed in to access that page.")
    |> Phoenix.Controller.redirect(to: page_path(conn, :index))
  end
end
