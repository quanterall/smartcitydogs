defmodule SmartcitydogsWeb.Api.UserController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.User
  alias SmartcitydogsWeb.Encoder

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
end
