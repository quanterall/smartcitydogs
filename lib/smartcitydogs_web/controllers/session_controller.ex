defmodule SmartcitydogsWeb.SessionController do
  use SmartcitydogsWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Smartcitydogs.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> redirect(to: redirect_to(conn))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Невалиден Email или парола!")
        |> redirect(to: home_path(conn, :index, modal: "login-form"))
    end
  end

  def redirect_to(conn) do
    case NavigationHistory.last_path(conn, []) do
      "/sessions/new" -> "/"
      path -> path
    end
  end

  def delete(conn, _) do
    conn
    |> Smartcitydogs.Auth.logout()
    |> redirect(to: home_path(conn, :index))
  end
end
