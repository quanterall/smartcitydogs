defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  alias Smartcitydogs.Signals
  alias Smartcitydogs.SignalsLikes
  import Ecto.Query
  plug(:put_layout, false when action in [:new])

  def index(conn, _params) do
    # todo: for admin

    # render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Smartcitydogs.Auth.login(user)
        |> redirect(to: user_path(conn, :show, user))

      {:error, user_changeset} ->
        render(conn, "new.html", user_changeset: user_changeset)
    end
  end

  def show(conn, id) do
    preload = [
      :signals_images,
      :signals_types,
      :signals_categories,
      :signals_comments,
      :signals_likes
    ]

    user_signals =
      Signals
      |> limit(6)
      |> where(users_id: ^id)
      |> Repo.all()
      |> Repo.preload(preload)

    followed_signals =
      SignalsLikes
      |> limit(6)
      |> where(users_id: ^id)
      |> Repo.all()
      |> Repo.preload([:signals])
      |> Enum.map(fn x -> x.signals end)
      |> Repo.preload(preload)

    render(conn, "show.html", user_signals: user_signals, followed_signals: followed_signals)
  end

  def edit(conn, %{"id" => id}) do
    user =
      User
      |> Repo.get(id)

    user_changeset =
      user
      |> User.changeset(%{})

    render(conn, "edit.html", user: user, user_changeset: user_changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)

    result =
      User.changeset(user, user_params)
      |> Repo.update()

    case result do
      {:ok, user} ->
        redirect(conn, to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = user_changeset} ->
        render(conn, "edit.html", user: user, user_changeset: user_changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = DataUsers.get_user!(id)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Users.Policy,
             :delete,
             conn.assigns.current_user
           ) do
      logged_user_id = conn.assigns.current_user.id
      request_user_id = user.id

      if logged_user_id != request_user_id do
        render(conn, SmartcitydogsWeb.ErrorView, "401.html")
      else
        {:ok, _user} = DataUsers.delete_user(user)

        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: user_path(conn, :index))
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end
end
