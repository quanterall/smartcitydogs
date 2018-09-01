defmodule SmartcitydogsWeb.UserController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.User
  alias Smartcitydogs.Repo
  alias Smartcitydogs.DataSignals

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


  def show(conn,  %{"followed_signals" => _, "id" => _, "page" => page_num}) do
    
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
    
         
          followed_signals = Smartcitydogs.DataSignals.get_signal_like(conn.assigns.current_user.id)
          liked_signals = Enum.map(followed_signals, fn x -> x |> Map.get(:signals_id) end)
          followed_signals = []
          followed_signals = for sig <- liked_signals, do: followed_signals ++ sig |> DataSignals.get_signal()
          page = Smartcitydogs.Repo.paginate(followed_signals, page: page_num, page_size: 8)
          
          render(conn, "show_my_followed_signals.html", user: user, conn: conn, page: page_num)
      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def show(conn, %{"followed_signals" => _, "id" => _}) do
    
    user = Repo.get!(User, conn.assigns.current_user.id) |> Repo.preload(:users_types) ##|> Map.put(:liked_signals, DataSignals.list_signals())
    # changeset = DataUsers.change_user(user)
  ##  sig = DataSignals.list_signals()
   ## user = user |> Map.put(:liked_signals, sig) |> Repo.update!()

    IO.inspect user
    IO.puts "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
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
     ##   if Enum.count(params) == 2 do
         
          followed_signals = Smartcitydogs.DataSignals.get_signal_like(conn.assigns.current_user.id)
          liked_signals = Enum.map(followed_signals, fn x -> x |> Map.get(:signals_id) end)
          IO.inspect liked_signals
          followed_signals = []
          followed_signals = for sig <- liked_signals, do: followed_signals ++ sig |> DataSignals.get_signal()
          page = Smartcitydogs.Repo.paginate(followed_signals, page: 1, page_size: 8)
          IO.inspect page
          
          render(conn, "show.html", user: user, conn: conn, page: 1)
        # else  
        #   IO.puts "R"
        #   page_params = params["page"]
        #   render(conn, "show_my_followed_signals.html.html", user: user, conn: conn, page: String.to_integer(page_params) )
        # end

      end
    else
      {:error, _} -> render(conn, SmartcitydogsWeb.ErrorView, "401.html")
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
          IO.puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
         ## IO.inspect page_params
         ## page = Smartcitydogs.Repo.paginate(page: page_params, page_size: 8)
          render(conn, "show_my_signals.html", user: user, conn: conn, page: String.to_integer(page_params) )
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
