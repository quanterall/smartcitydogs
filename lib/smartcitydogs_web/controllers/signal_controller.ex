defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Repo
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Repo
  alias Smartcitydogs.Animals
  import Ecto.Query

  plug(:put_layout, false when action in [:filter_index])
  plug(:put_layout, false when action in [:adopted_animals])
  plug(:put_layout, false when action in [:shelter_animals])
  plug(:put_layout, false when action in [:filter_animals])
  plug(:put_layout, false when action in [:new])

 def index(conn, params) do
    page = Signals |> Smartcitydogs.Repo.paginate(params)
    sorted_signals = DataSignals.sort_signal_by_id()
    render(conn, "index2_signal.html", signal: page.entries, page: page)
  end 

  def index_home_minicipality(conn, params) do
    IO.inspect params
    IO.puts "REEEEEEEEEEEEEEEEEEE"
    page = Signals |> Smartcitydogs.Repo.paginate(params)
    sorted_signals = DataSignals.sort_signal_by_id()
    render(conn, "filter_index.html", signal: page.entries, page: page)
  end 

  def new(conn, _params) do
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})

    logged_user_type_id = conn.assigns.current_user.users_types.id
    ##IO.inspect(logged_user_type_id)

    if logged_user_type_id == 4 || logged_user_type_id == 2 do
     ## IO.inspect(conn)
      render(conn, "new_signal.html", changeset: changeset)
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def create(conn, %{"signals" => signal_params}) do
    a = conn.assigns.current_user.id
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 4 || logged_user_type_id == 2 do
      signal_params =
        signal_params
        |> Map.put("signals_types_id", 1)
        |> Map.put("view_count", 0)
        |> Map.put("support_count", 0)
        |> Map.put("users_id", a)

      case DataSignals.create_signal(signal_params) do
        {:ok, signal} ->
          upload = Map.get(conn, :params)
          upload = Map.get(upload, "signals")
          upload = Map.get(upload, "url")
          for n <- upload do
            extension = Path.extname(n.filename)

            File.cp(
              n.path,
              "../smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{extension}"
            )

            args = %{
              "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
              "signals_id" => "#{signal.id}"
            }

            DataSignals.create_signal_images(args)
          end

          redirect(conn, to: signal_path(conn, :show, signal))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new_signal.html", changeset: changeset)
          
      end
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def show(conn, %{"id" => id}) do
    comments = DataSignals.get_comment_signal_id(id)
    signal = DataSignals.get_signal(id)
    xaa = Enum.find(conn.assigns.current_user.liked_signals, fn(elem) -> elem == to_string(signal.id) end)
    ##signal is liked by user
    sorted_comments = DataSignals.sort_signal_comment_by_id
      ##IO.inspect kkkkk
   if xaa == nil do 
      render(conn, "show_signal.html", signal: signal, comments: sorted_comments)
   else
    render(conn, "show_signal.html", signal: signal, comments: sorted_comments)
   end
  end

  def edit(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    logged_user_type_id = conn.assigns.current_user.users_types.id
    if logged_user_type_id == 2 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      changeset = DataSignals.change_signal(signal)
      render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal = DataSignals.get_signal(id)
    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 2 do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      case DataSignals.update_signal(signal, signal_params) do
        {:ok, signal} ->
          conn
          |> put_flash(:info, "Signal updated successfully.")
          |> render("show_signal.html", signal: signal)
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit_signal.html", signal: signal, changeset: changeset)
      end
    end
  end

  def add_like(conn, params) do
    signal = DataSignals.get_signal(params["id"])
    comments = DataSignals.get_comment_signal_id(params["id"])

    xaa =
      Enum.find(conn.assigns.current_user.liked_signals, fn elem ->
        elem == to_string(signal.id)
      end)

    if xaa == nil do
      user_id = conn.assigns.current_user.id
      sup = Map.get(signal, :support_count)
      signal_params = %{support_count: sup+1}
      DataUsers.add_liked_signal(user_id, signal.id)

      case DataSignals.update_signal(signal, signal_params) do
        {:ok, signal} ->
        redirect conn, to: "/signals/#{params["id"]}"
        {:error, %Ecto.Changeset{} = changeset} ->
          redirect conn, to: "/signals/#{params["id"]}"
        end
   end
   redirect conn, to: "/signals/#{params["id"]}"
  end

  def add_comment_like(conn, params) do
    comment = DataSignals.get_signal_comment(params["id"])
  ##  IO.inspect comment
    signal = DataSignals.get_signal(params["signal_id"])
    xaa = Enum.find(conn.assigns.current_user.liked_comments, fn(elem) -> elem == to_string(comment.id) end)
    IO.puts "))))))"
     xaa2 = Enum.find(conn.assigns.current_user.disliked_comments, fn(elem) -> elem == to_string(comment.id) end)
     IO.inspect xaa
     IO.inspect xaa2

    if xaa != nil do ##if the comment was liked before

    end


     if xaa2 != nil && xaa == nil do ##if the comment was disliked before and not liked before
     disliked_list =  conn.assigns.current_user.id |> DataUsers.get_user! |> Map.get(:disliked_comments)
     liked_list =  conn.assigns.current_user.id |> DataUsers.get_user! |> Map.get(:liked_comments)
      IO.puts "0000000000000000000000000000000000000000000"
      IO.inspect disliked_list
      IO.inspect liked_list
      IO.puts "0000000000000000000000000000000000000000000"
      disliked_list =  disliked_list |> List.delete(to_string(comment.id))
     ## liked_list = liked_list |> List.delete(to_string(comment.id))
      IO.inspect disliked_list
    user =  conn.assigns.current_user.id |> DataUsers.get_user! 
    user_change = %{disliked_comments: disliked_list}
    sup = Map.get(comment, :likes_number)
    signal_params = %{likes_number: sup+1}
    DataUsers.add_liked_signal_comment(user.id, comment.id)
   ## comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
    IO.inspect comment
    IO.inspect signal_params
    userrr = DataUsers.update_user(conn.assigns.current_user.id |> DataUsers.get_user!, user_change) 
    
    IO.inspect userrr
    IO.inspect "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    case DataSignals.update_signal_comment(comment, signal_params) do
      {:ok, comment} ->
      
      all_comments = DataSignals.get_comment_signal_id(signal.id)           
      IO.inspect all_comments 
      IO.puts "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR"      
      redirect conn, to: "/signals/#{signal.id}"                                                       
      ##   conn
       ##   |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
          {:error, %Ecto.Changeset{} = changeset} ->
            redirect conn, to: "/signals/#{signal.id}" 
          ##  render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
    end
 ## conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:liked_comments) 
  ## DataUsers.update_user(user, user_change)
    end

    if xaa == nil && xaa2 == nil do ## if the comment was not liked before
      user_id = conn.assigns.current_user.id
      sup = Map.get(comment, :likes_number)
      signal_params = %{likes_number: sup + 1}
      DataUsers.add_liked_signal_comment(user_id, comment.id)
      comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)

      case DataSignals.update_signal_comment(comment, signal_params) do
      {:ok, comment} ->
##        IO.puts "------------------------------"
        all_comments2 = DataSignals.get_comment_signal_id(signal.id) |> Enum.find(fn(x) -> if x.id == comment.id  do x =  x |> DataSignals.update_signal_comment(signal_params) end end) 
        all_comments = DataSignals.get_comment_signal_id(signal.id)                            
##        IO.inspect all_comments     
redirect conn, to: "/signals/#{signal.id}"                                             
         ##conn
        ##  |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
      {:error, %Ecto.Changeset{} = changeset} ->
##        IO.inspect changeset
redirect conn, to: "/signals/#{signal.id}"
         ## render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
       end
##       IO.inspect comment
redirect conn, to: "/signals/#{signal.id}"
     ##  render(conn, "show_signal_no_comment_like.html", signal: signal, comments: comment)
     end
##     IO.puts ":::::::::::::::::::::::::::::::::::::::::"
##     IO.inspect comment

redirect conn, to: "/signals/#{signal.id}"
 ##  render(conn, "show_signal_no_comment_like.html", signal: signal, comments: [comment])
  end

  def add_comment_dislike(conn, params) do
    comment = DataSignals.get_signal_comment(params["id"])
    signal = DataSignals.get_signal(params["signal_id"])
    disliked_list = Enum.find(conn.assigns.current_user.disliked_comments, fn(elem) -> elem == to_string(comment.id) end)
    liked_list = Enum.find(conn.assigns.current_user.liked_comments, fn(elem) -> elem == to_string(comment.id) end)
    IO.puts "0000000000000000000000000000000000000000000"
      IO.inspect disliked_list
      IO.inspect liked_list
      IO.puts "0000000000000000000000000000000000000000000"

    if liked_list != nil && disliked_list == nil do ##if the comment was liked before
     liked_comments =  conn.assigns.current_user.id |> DataUsers.get_user! |> Map.get(:liked_comments)
     IO.puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
     IO.inspect liked_comments
     IO.puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
     liked_comments =  liked_comments |> List.delete(to_string(comment.id))
     IO.inspect liked_comments
    user =  conn.assigns.current_user.id |> DataUsers.get_user! 
    user_change = %{liked_comments: liked_comments}
    userrr = DataUsers.update_user(conn.assigns.current_user.id |> DataUsers.get_user!, user_change) 
    IO.inspect userrr
    IO.puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    IO.inspect user_change
    sup = Map.get(comment, :likes_number)
    signal_params = %{likes_number: sup-1}
   ## DataUsers.add_disliked_signal_comment(user.id, comment.id)
   ## comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
    IO.inspect comment
    IO.inspect signal_params
    case DataSignals.update_signal_comment(comment, signal_params) do
      {:ok, comment} ->
      all_comments = DataSignals.get_comment_signal_id(signal.id)           
      IO.inspect all_comments       
      redirect conn, to: "/signals/#{signal.id}"                                                      
        ## conn
       ##   |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "show_signal.html", signal: signal, comments: changeset)
    end
 ## conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:liked_comments) 
  ## DataUsers.update_user(user, user_change)
    end

    if disliked_list == nil do 
      user_id = conn.assigns.current_user.id
      sup = Map.get(comment, :likes_number)
      signal_params = %{likes_number: sup - 1}
      DataUsers.add_disliked_signal_comment(user_id, comment.id)
      comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
      conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:liked_comments)

      case DataSignals.update_signal_comment(comment, signal_params) do
      {:ok, comment} ->
        all_comments2 = DataSignals.get_comment_signal_id(signal.id) |> Enum.find(fn(x) -> if x.id == comment.id  do x =  x |> DataSignals.update_signal_comment(signal_params) end end) 
        all_comments = DataSignals.get_comment_signal_id(signal.id)                     
        redirect conn, to: "/signals/#{signal.id}"                                                   
       ## conn
       ##   |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
      {:error, %Ecto.Changeset{} = changeset} ->
        redirect conn, to: "/signals/#{signal.id}"
        ##  render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
       end
       redirect conn, to: "/signals/#{signal.id}"
      ## render(conn, "show_signal_no_comment_like.html", signal: signal, comments: comment)
     end

    ## redirect conn, to: "/signals/#{signal.id}"
    comment = DataSignals.list_signal_comment
    IO.inspect comment
    IO.puts "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
    redirect conn, to: "/signals/#{signal.id}"
  ##render(conn, "show_signal_no_comment_like.html", signal: signal, comments: comment)


      render(conn, "show_signal.html", signal: signal, comments: comment)


    comment = DataSignals.list_signal_comment()
    render(conn, "show_signal.html", signal: signal, comments: comment)
  end


  def followed_signals(conn, params) do
    user_like = conn.assigns.current_user.liked_signals

    all_followed_signals =
      Enum.map(user_like, fn elem ->
        String.to_integer(elem) |> DataSignals.get_signal()
      end)

    page = Signals |> Smartcitydogs.Repo.paginate(params)
    render(conn, "followed_signals.html", signal: all_followed_signals, page: page)
  end

  def get_signals_support_count(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)

    if list != [] do
      [head | tail] = list
      count = head.support_count
      Smartcitydogs.DataSignals.update_signal(head, %{support_count: count + 1})
    end

    head.support_count + 1
  end

  def update_like_count(conn, %{"show-count" => show_count, "show-id" => show_id}) do
    ## IO.inspect show_id
    signal = DataSignals.get_signal(show_id)
    ## IO.inspect signal
    ## IO.puts "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    user_id = conn.assigns.current_user.id
    ##  IO.inspect user_id
    DataUsers.add_liked_signal(user_id, show_id)
    count = get_signals_support_count(show_id)

    conn
    |> json(%{new_count: count})
  end

  def update_type(conn, %{"id" => id, "signals_types_id" => signals_types_id}) do
    signal = DataSignals.get_signal(id)
    DataSignals.update_signal(signal, %{"signals_types_id" => signals_types_id})

    signals = DataSignals.list_signals()
    render(conn, "index_signals.html", signals: signals)
  end

  def comment(conn, %{"show-comment" => show_comment, "show-id" => show_id}) do
    user_id = conn.assigns.current_user.id

    Smartcitydogs.DataSignals.create_signal_comment(%{
      comment: show_comment,
      signals_id: show_id,
      users_id: user_id
    })

    render("show_signal.html")
  end

  def delete(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    logged_user_id = conn.assigns.current_user.id

    if logged_user_id != signal.users_id do
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    else
      {:ok, _signal} = DataSignals.delete_signal(id)

      conn
      |> put_flash(:info, "Signal deleted successfully.")
      |> redirect(to: signal_path(conn, :index))
    end
  end

  def filter_index(conn, params) do
    
    params = params["obj"]
    IO.inspect params
    cond do
     params["sig_category"]  -> 
      all_query = []
        x = 
      Enum.map(params["sig_category"] , fn(x)-> struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))  
      all_query = all_query ++ Repo.all(struct) end)
      x = List.flatten(x)
      page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
      render(conn, "index_signal.html", signal: page.entries, page: page)
     params["sig_status"]  ->
        all_query = []
        x = 
      Enum.map(params["sig_status"] , fn(x)-> struct = from(p in Signals, where: p.signals_types_id == ^String.to_integer(x))  
      all_query = all_query ++ Repo.all(struct) end)
      x = List.flatten(x)
      page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
      render(conn, "index_signal.html", signal: page.entries, page: page)
     params["type"] == nil ->
        x = DataSignals.list_signals
        page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
        render(conn, "index_signal.html", signal: page.entries, page: page)
     params == %{} ->
        x = DataSignals.list_signals
        page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
        render(conn, "index_signal.html", signal: page.entries, page: page)
    end
    page = Signals |> Smartcitydogs.Repo.paginate(params)
    sorted_signals = DataSignals.sort_signal_by_id()
    render(conn, "index_signal.html", signal: page.entries, page: page)
  end

  def adopted_animals(conn, params) do
    struct = from(p in Animals, where: p.animals_status_id == 2)
    all_adopted = Repo.all(struct) |> Repo.preload(:animals_status)
    page = Smartcitydogs.Repo.paginate(all_adopted, page: 1, page_size: 8)
    render(conn, "adopted_animals.html", animals: page.entries, page: page)
  end

  def shelter_animals(conn, params) do
    struct = from(p in Animals, where: p.animals_status_id == 3)
    all_adopted = Repo.all(struct) |> Repo.preload(:animals_status)
    page = Smartcitydogs.Repo.paginate(all_adopted, page: 1, page_size: 8)
    render(conn, "shelter_animals.html", animals: page.entries, page: page)
  end


  def filter_animals(conn, params) do
    if params == %{} do
      x = DataAnimals.list_animals
      page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
      render(conn, "filter_animals.html", animals: x, page: page)
    end
    params = Map.values(params)    
    [inner_map] =  params
    inner_map = Map.values(inner_map)
    [id] = inner_map
    all_query = []
    x = 
    Enum.map(id, fn(x)-> struct = from(p in Animals, where: p.animals_status_id == ^String.to_integer(x))  
    all_query = all_query ++ Repo.all(struct) |> Repo.preload(:animals_status)   end)
    x = List.flatten(x)
    page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
    render(conn, "filter_animals.html", animals: x, page: page)
  end





end
