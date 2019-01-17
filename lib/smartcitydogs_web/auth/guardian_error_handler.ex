defmodule Smartcitydogs.GuardianErrorHandler do
  def unauthenticated(conn, _params) do
    last_path =
      if NavigationHistory.last_path(conn) == Phoenix.Controller.current_path(conn) do
        "/"
      else
        NavigationHistory.last_path(conn)
      end

    conn
    |> Phoenix.Controller.put_flash(
      :error,
      "За достъп до тази функционалност е необходимо да се впишете в акаунта Ви или да се регистрирате."
    )
    |> Phoenix.Controller.redirect(to: last_path)
  end
end
