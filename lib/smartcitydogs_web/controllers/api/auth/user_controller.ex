defmodule SmartcitydogsWeb.Api.UserController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  alias Smartcitydogs.Guardian
  alias SmartcitydogsWeb.Encoder

  def create(conn, %{"user" => %{"email" => email} = params}) do
    case Repo.get_by(User, email: email) do
      nil ->
        with {:ok, %User{} = user} <- User.create(params),
             {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
          data = %{token: token, user: Encoder.struct_to_map(user)}

          conn
          |> json(data)
        end

      _ ->
        json(conn, %{error: "user exist"})
    end
  end

  def show(conn, _) do
    data =
      Guardian.Plug.current_resource(conn)
      |> Encoder.struct_to_map()

    json(conn, data)
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case User.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        json(conn, %{token: token})

      _ ->
        json(conn, %{error: :unauthorized})
    end
  end
end
