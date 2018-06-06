defmodule SmartcitydogsWeb.SessionController do
  use SmartcitydogsWeb, :controller
  plug(Ueberauth)
  plug(:scrub_params, "session" when action in ~w(create)a)
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Smartcitydogs.User

  def new(conn, _) do
    render(conn, "new.html")
  end

  # def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
  #   # try to get user by unique email from DB
  #   user = Repo.get_by(User, email: email)

  #   # examine the result
  #   result =
  #     cond do
  #       # if user was found and provided password hash equals to stored
  #       # hash
  #       user && checkpw(password, user.password_hash) ->
  #         {:ok, login(conn, user)}

  #       # else if we just found the use
  #       user ->
  #         {:error, :unauthorized, conn}

  #       # otherwise
  #       true ->
  #         # simulate check password hash timing
  #         dummy_checkpw
  #         {:error, :not_found, conn}
  #     end

  #   case result do
  #     {:ok, conn} ->
  #       conn
  #       |> put_flash(:info, "You’re now logged in!")
  #       |> redirect(to: page_path(conn, :index))

  #     {:error, _reason, conn} ->
  #       conn
  #       |> put_flash(:error, "Invalid email/password combination")
  #       |> render("new.html")
  #   end
  # end



  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Smartcitydogs.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You’re now signed in!")
        |> redirect(to: page_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    IO.inspect(auth)

    case Smartcitydogs.DataUsers.get_user_by_email!(auth.info.email) do
      nil ->
        case Smartcitydogs.DataUsers.create_user_from_auth(auth) do
          {:ok, user} ->
            conn
            |> login(user)
            |> put_flash(:info, "You’re now signed in!")
            |> redirect(to: "/")

          {:error, changeset} ->
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

  # def delete(conn, _) do
  #   conn
  #   |> logout
  #   |> put_flash(:info, "See you later!")
  #   |> redirect(to: page_path(conn, :index))
  # end

  def delete(conn, _) do
    conn
    |> Smartcitydogs.Auth.logout()
    |> put_flash(:info, "See you later!")
    |> redirect(to: page_path(conn, :index))
  end

  defp logout(conn) do
    Guardian.Plug.sign_out(conn)
  end
end
