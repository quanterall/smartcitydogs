defmodule Smartcitydogs.GuardianErrorHandler do
  import SmartcitydogsWeb.Router.Helpers

  def unauthenticated(conn, _params) do
    conn
    |> Phoenix.Controller.put_flash(
      :error,
      "За достъп до тази функционалност е необходимо да се впишете в акаунта Ви или да се регистрирате."
    )
    |> Phoenix.Controller.redirect(to: NavigationHistory.last_path(conn))
  end
end
