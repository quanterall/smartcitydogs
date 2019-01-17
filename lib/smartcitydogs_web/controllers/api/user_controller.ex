defmodule SmartcitydogsWeb.UserControllerAPI do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.User
  alias Smartcitydogs.DataUsers
  plug(Ueberauth)

  ## action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    users = DataUsers.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case DataUsers.get_user_by_email!(user_params["email"]) do
      nil ->
        with {:ok, %User{} = user} <- DataUsers.create_user(user_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", user_path(conn, :show, user))
          |> render("show.json", user: user)
        end

      _ ->
        conn
        |> render(SmartcitydogsWeb.ErrorView, "401.json", message: "User already exists!")
    end
  end

  def show(conn, %{"id" => id}) do
    user_id = conn.private.plug_session["current_user_id"]

    if(Integer.to_string(user_id) == id) do
      user = DataUsers.get_user!(id)
      render(conn, "show.json", user: user)
    else
      render(conn, "401.json", user: "Not autorization!")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Smartcitydogs.Auth.login_by_email_and_pass(conn, email, password) do
      {:ok, conn} ->
        user = Guardian.Plug.current_resource(conn)

        if user.user_type_id == 4 || user.user_type_id == 5 do
          conn
          |> put_session(:current_user_id, user.id)
          |> put_status(:ok)
          |> render(SmartcitydogsWeb.UserControllerAPIView, "municipality_sign_in.json",
            user: user
          )
        else
          conn
          |> put_session(:current_user_id, user.id)
          |> put_status(:ok)
          |> render(SmartcitydogsWeb.UserControllerAPIView, "sign_in.json", user: user)
        end

      {:error, message, conn} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> render(SmartcitydogsWeb.ErrorView, "401.json", message: message)
    end
  end

  def logout(conn, _) do
    conn
    |> delete_session(:current_user_id)
    |> put_status(:ok)
    |> render(SmartcitydogsWeb.UserControllerAPIView, "logout.json", conn)
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Smartcitydogs.DataUsers.get_user_by_facebook_uid(auth.uid) do
      nil ->
        conn
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")

      user ->
        conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")
    end
  end
end
