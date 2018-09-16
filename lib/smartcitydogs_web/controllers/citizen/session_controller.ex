defmodule SmartcitydogsWeb.SessionController do
  use SmartcitydogsWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Smartcitydogs.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You’re now signed in!")
        |> redirect(to: NavigationHistory.last_path(conn, []))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> redirect(to: page_path(conn, :index, show_login: true))
    end
  end

  def delete(conn, _) do
    conn
    |> Smartcitydogs.Auth.logout()
    |> put_flash(:info, "See you later!")
    |> redirect(to: page_path(conn, :index))
  end
end
