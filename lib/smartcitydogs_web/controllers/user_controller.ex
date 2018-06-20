defmodule SmartCityDogsWeb.UserController do
  use SmartCityDogsWeb, :controller
  alias SmartCityDogs.Users
  alias SmartCityDogs.Users.User
  plug Ueberauth

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case SmartCityDogs.Users.authenticate_user(email, password) do
      {:ok, user} ->
        #SmartCityDogs.Users.is_active(user.id, true)
        System.cmd("espeak", ["Welcome"])

        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> render(SmartCityDogsWeb.UserView, "sign_in.json", user: user)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> render(SmartCityDogsWeb.UserView, "401.json", message: message)
    end
  end

  def logout(conn, %{"id" => id}) do
    user = SmartCityDogs.Users.get_user!(id)

    #if user.is_active == true do
      # case MyApi.Auth.authenticate_user(email, password) do
      # {:ok, user} ->
      #SmartCityDogs.Users.is_active(user.id, false)
      System.cmd("espeak", ["goodbye "])

      conn
      |> delete_session(:current_user_id)
      |> put_status(:ok)
      |> render(SmartCityDogsWeb.UserView, "logout.json", user: user)
    #end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case SmartCityDogs.Users.get_user_by_facebook_uid(auth.uid) do
      nil ->
        conn
        |> redirect(to: "/")
      user ->
        conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

end
