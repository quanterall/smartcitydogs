defmodule SmartcitydogsWeb.SessionController do
  use SmartcitydogsWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case Smartcitydogs.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> redirect(to: NavigationHistory.last_path(conn, []))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Невалиден Email или парола!")
        |> redirect(to: page_path(conn, :index, modal: "login-form"))
    end
  end

  def delete(conn, _) do
    conn
    |> Smartcitydogs.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
