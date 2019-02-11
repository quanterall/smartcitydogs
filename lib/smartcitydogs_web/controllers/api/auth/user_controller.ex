defmodule SmartcitydogsWeb.Api.UserController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.User
  alias SmartcitydogsWeb.Encoder
  alias Smartcitydogs.{Mailer, Email}

  def create(conn, %{"user" => params}) do
    with {:ok, %User{} = user} <- User.create(params),
         {:ok, token, _claims} <- Smartcitydogs.Guardian.encode_and_sign(user) do
      data = %{token: token, user: Encoder.struct_to_map(user)}

      conn
      |> json(data)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SmartcitydogsWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"user" => params}) do
    %{id: id} = Guardian.Plug.current_resource(conn)
    user = User.update(id, params)

    conn
    |> json(%{user: Encoder.struct_to_map(user)})
  end

  def show(conn, _) do
    data =
      Guardian.Plug.current_resource(conn)
      |> User.preload()
      |> Encoder.struct_to_map()

    json(conn, data)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case User.token_sign_in(email, password) do
      {:ok, token, _} ->
        {:ok, user} = User.get_by_email(email)
        json(conn, %{token: token, user: Encoder.struct_to_map(user)})

      _ ->
        conn
        |> put_status(403)
        |> json(%{error: :unauthorized})
    end
  end

  def forget_password(conn, %{"email" => email}) do
    token =
      Phoenix.Token.sign(
        SmartcitydogsWeb.Endpoint,
        Application.fetch_env!(:smartcitydogs, :secret_salt),
        email
      )

    Email.send_email(
      email,
      "Забравена парола от Smartcitydogs",
      "forget_password.html",
      email: email,
      token: token,
      conn: conn
    )
    |> Mailer.deliver_later()

    json(conn, %{success: "E-mail with password is send!"})
  end
end
