defmodule SmartcitydogsWeb.SessionController do
  use SmartcitydogsWeb, :controller

  plug(:put_layout, false when action in [:new])
  plug(Ueberauth)
  plug(:scrub_params, "session" when action in ~w(create)a)
  # import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  # import Logger

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Smartcitydogs.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You’re now signed in!")
        |> redirect(to: page_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> redirect(to: page_path(conn, :index, show_login: true))
        |> put_flash(:error, "Invalid email/password combination")
    end
  end

  def callback(conn = %{assigns: %{ueberauth_failure: _fails}}, _params) do
    # Logger.warn("Authentication failed", conn: conn)

    conn
    |> redirect(to: "/session/new")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Smartcitydogs.DataUsers.get_user_by_email!(auth.info.email) do
      nil ->
        case Smartcitydogs.DataUsers.create_user_from_auth(auth) do
          {:ok, user} ->
            conn
            |> login(user)
            |> put_flash(:info, "You’re now signed in!")
            |> redirect(to: "/")

          {:error, _} ->
            conn
            |> put_flash(:error, "Fail to store to DB")
            |> redirect(to: "/")
        end

      user ->
        conn
        |> login(user)
        |> put_flash(:info, "You’re now signed in!")
        |> redirect(to: "/")
    end
  end

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def delete(conn, _) do
    conn
    |> Smartcitydogs.Auth.logout()
    |> put_flash(:info, "See you later!")
    |> redirect(to: page_path(conn, :index))
  end
end
