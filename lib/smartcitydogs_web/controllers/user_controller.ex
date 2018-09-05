defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals

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

  def create(conn, user_params) do
    if user_params["checked"] != "true" do
      changeset = %User{} |> User.registration_changeset(user_params)

      conn
      |> put_flash(:info, "agree with the rules")

      render(conn, "new.html", changeset: changeset)
    else
      user_params =
        user_params
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

  def show(conn, %{"followed_signals" => _, "id" => _, "page" => page_num}) do
    user = Repo.get!(User, conn.assigns.current_user.id) |> Repo.preload(:users_types)

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
        {page, signals} = Signals.get_button_signals(user.id, page_num)
        profile_params = %{signals: signals, page: page, conn: conn}   
        render(conn, "show_my_followed_signals.html", user: user, conn: conn, page: page, profile_params: profile_params)
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def show(conn, %{"followed_signals" => _, "id" => _}) do
    
    user = Repo.get!(User, conn.assigns.current_user.id) |> Repo.preload(:users_types) 
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
          render(conn, "show.html", user: user, conn: conn, page: 1)
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def show(conn, params) do
    id = params["id"]
    user = Repo.get!(User, id) |> Repo.preload(:users_types)
 

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
        
        signals = DataSignals.get_user_signal(user.id)
        page = Repo.paginate(signals, page: 1, page_size: 8)
        profile_params = %{signals: signals, page: page, conn: conn}
        {page} = Signals.get_button_signals(user.id)
        profile_liked_params = %{signals: page, page: page, conn: conn}

        if Enum.count(params) == 1 do
          render(conn, "show.html", user: user, conn: conn, profile_params: profile_params, profile_liked_params: profile_liked_params)
        else  
          page_my_signals = Repo.paginate(signals, page: params["page"], page_size: 8)
          render(conn, "show_my_signals.html", user: user, conn: conn, page: page_my_signals, profile_liked_params: profile_liked_params )
        end
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
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
