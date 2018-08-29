defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.User
  alias Smartcitydogs.Repo

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
      {:error, raison} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, user_params) do
    if user_params["checked"] != "true" do
    
      changeset = %User{} |> User.registration_changeset(user_params)

      conn
      |> put_flash(:info, "agree with the rules")

      render(conn, "new.html", changeset: changeset)
    else
      user_params = user_params
        |> Map.put("users_types_id", 2)
      changeset = %User{} |> User.registration_changeset(user_params)

      case Repo.insert(changeset) do
        {:ok, user} ->
          conn
          |> Smartcitydogs.Auth.login(user)
          |> put_flash(:info, "#{user.username} created!")
          |> redirect(to: user_path(conn, :show, user))

        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, params) do
    id = params["id"]
    user = Repo.get!(User, id) |> Repo.preload(:users_types)
    # changeset = DataUsers.change_user(user)

    with :ok <-
           Bodyguard.permit(
             Smartcitydogs.Users.Policy,
             :show,
             conn.assigns.current_user
           ) do
      logged_user_id = conn.assigns.current_user.id
      request_user_id = user.id

      if logged_user_id != request_user_id do
        render(conn, SmartcitydogsWeb.ErrorView, "401.html")
      else
        if Enum.count(params) == 1 do

          page = Smartcitydogs.Repo.paginate(page: 1, page_size: 8)
          render(conn, "show.html", user: user, conn: conn, page: page)
        else  
          page_params = params["page"]
          page = Smartcitydogs.Repo.paginate(page: page_params, page_size: 8)
          render(conn, "show.html", user: user, conn: conn, page: page)
        end

      end
    else
      {:error, raison} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
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
      {:error, raison} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
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
      {:error, raison} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
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
      {:error, raison} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end
end
