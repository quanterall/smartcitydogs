defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.Guardian
  alias Smartcitydogs.User
  alias SmartcitydogsWeb.Encoder

  def show(conn, _) do
    data =
      Guardian.Plug.current_resource(conn)
      |> Encoder.struct_to_map()

    json(conn, data)
  end

  def forget_password(conn, %{"token" => token}) do
    conn
    |> assign(:token, token)
    |> render("forget_password.html")
  end

  def reset_password(conn, %{
        "token" => token,
        "new_password" => password,
        "confirm_new_password" => password
      }) do
    {:ok, email} =
      Phoenix.Token.verify(
        SmartcitydogsWeb.Endpoint,
        Application.fetch_env!(:smartcitydogs, :secret_salt),
        token,
        max_age: 86400
      )

    with {:ok, %{id: id}} <- User.get_by_email(email) do
      User.update(id, %{"password" => password})

      conn
      |> render("android_login.html")
    else
      _ ->
        conn
        |> assign(:token, token)
        |> render("forget_password.html")
    end
  end
end
