defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.SignalsLikes
  import Ecto.Query
  plug(:put_layout, false when action in [:new])

  def index(conn, _params) do
    users = DataUsers.list_users()

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Users.Policy,
             :index,
             conn.assigns.current_user
           ) do
      render(conn, "index.html", users: users)
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
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
    user_signals =
      Signals
      |> limit(6)
      |> where(users_id: ^conn.assigns.current_user.id)
      |> Repo.all()
      |> Repo.preload([
        :signals_images,
        :signals_types,
        :signals_categories,
        :signals_comments,
        :signals_likes
      ])

    followed_signals =
      SignalsLikes
      |> limit(6)
      |> where(users_id: ^conn.assigns.current_user.id)
      |> Repo.all()
      |> Repo.preload([:signals])
      |> Enum.map(fn x -> x.signals end)
      |> Repo.preload([
        :signals_images,
        :signals_types,
        :signals_categories,
        :signals_comments,
        :signals_likes
      ])

    render(conn, "show.html", user_signals: user_signals, followed_signals: followed_signals)
  end

  def edit(conn, %{"id" => id}) do
    user = DataUsers.get_user!(id)
    changeset = DataUsers.change_user(user)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Users.Policy,
             :edit,
             conn.assigns.current_user
           ) do
      logged_user_id = conn.assigns.current_user.id
      request_user_id = user.id

      if logged_user_id != request_user_id do
        render(conn, SmartcitydogsWeb.ErrorView, "401.html")
      else
        render(conn, "edit.html", user: user, changeset: changeset)
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = DataUsers.get_user!(id)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Users.Policy,
             :update,
             conn.assigns.current_user
           ) do
      logged_user_id = conn.assigns.current_user.id
      request_user_id = user.id

      if logged_user_id != request_user_id do
        render(conn, SmartcitydogsWeb.ErrorView, "401.html")
      else
        case DataUsers.update_user(user, user_params) do
          {:ok, user} ->
            conn
            |> put_flash(:info, "User updated successfully.")
            |> redirect(to: user_path(conn, :show, user))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", user: user, changeset: changeset)
        end
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
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
