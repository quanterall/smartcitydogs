defmodule Smartcitydogs.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Logger

  alias Smartcitydogs.User
  alias Smartcitydogs.Repo

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    user = Smartcitydogs.DataUsers.get_user_by_email!(email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}

      user ->
        {:error, :unauthorized, conn}

      true ->
        dummy_checkpw
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end

 
end
