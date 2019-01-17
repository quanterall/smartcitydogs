defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  alias Smartcitydogs.Signal
  alias Smartcitydogs.SignalLikes
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

  def show(conn, _) do
    preload = [
      :signal_images,
      :signal_type,
      :signal_category,
      :signal_comments,
      :signal_likes
    ]

    user_signals =
      Signal
      |> limit(6)
      |> where(user_id: ^conn.assigns.current_user.id)
      |> Repo.all()
      |> Repo.preload(preload)

    followed_signals =
      SignalLikes
      |> limit(6)
      |> where(user_id: ^conn.assigns.current_user.id)
      |> Repo.all()
      |> Repo.preload([:signals])
      |> Enum.map(fn x -> x.signals end)
      |> Repo.preload(preload)

    render(conn, "show.html", user_signals: user_signals, followed_signals: followed_signals)
  end

  def edit(conn, _) do
    user =
      User
      |> Repo.get(conn.assigns.current_user.id)

    user_changeset =
      user
      |> User.changeset(%{})

    render(conn, "edit.html", user: user, user_changeset: user_changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = Repo.get(User, conn.assigns.current_user.id)

    result =
      User.changeset(user, user_params)
      |> Repo.update()

    case result do
      {:ok, user} ->
        redirect(conn, to: user_path(conn, :show))

      {:error, %Ecto.Changeset{} = user_changeset} ->
        render(conn, "edit.html", user: user, user_changeset: user_changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = DataUsers.get_user!(id)

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
  end
end
