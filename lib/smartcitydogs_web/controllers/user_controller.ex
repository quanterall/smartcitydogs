defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  plug(:scrub_params, "user" when action in [:create])

  alias Smartcitydogs.User

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  #   def create(conn, %{"user" => user_params}) do
  #     # here will be an implementation
  #   end

  def create(conn, %{"user" => user_params}) do
    changeset = %User{} |> User.registration_changeset(user_params)
    IO.inspect(changeset)
    users = Map.get(changeset, :changes)
    IO.inspect(users)
    case Smartcitydogs.DataUsers.create_user(users) do
      {:ok, user} ->
        conn
        |> Smartcitydogs.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: user_path(conn, :show, user))

      # |> put_flash(:info, "#{user.name} created!")
      # |> redirect(to: user_path(conn, :show, user))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
