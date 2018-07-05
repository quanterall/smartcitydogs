defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Repo

  def index(conn, params) do
   # signal = DataSignals.list_signals()
   page = Signals |> Smartcitydogs.Repo.paginate(params)
   sorted_signals = DataSignals.sort_signal_by_id
   render(conn, "index_signal.html", signal: sorted_signals, page: page)
  end


  def new(conn, _params) do
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})
    render(conn, "new_signal.html", changeset: changeset)
  end

  def create(conn, %{"signals" => signal_params}) do
    a = conn.assigns.current_user.id

    signal_params =
      signal_params
      |> Map.put("signals_types_id", 1)
      |> Map.put("view_count", 1)
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
            "../smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{
              extension
            }"
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
  end

  def show(conn, %{"id" => id}) do
    comments = DataSignals.get_comment_signal_id(id)
    signal = DataSignals.get_signal(id)
    IO.inspect conn.assigns.current_user
    
   xaa = Enum.find(conn.assigns.current_user.liked_signals, fn(elem) -> elem == to_string(signal.id) end)
  ## IO.inspect xaa
  ##signal is liked by user
   if xaa == nil do 
    IO.inspect comments
    IO.puts "----"
    IO.inspect conn
      render(conn, "show_signal_no_like.html", signal: signal, comments: comments)
  ##  end end)  
   else
    render(conn, "show_signal.html", signal: signal, comments: comments)
   end
  end

  def edit(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    changeset = DataSignals.change_signal(signal)
    IO.puts "--------------------------------------"
    render(conn, "edit_signal.html", signal: signal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "signals" => signal_params}) do
    signal = DataSignals.get_signal(id)

    case DataSignals.update_signal(signal, signal_params) do
      
      {:ok, signal} ->
        conn
        |> put_flash(:info, "Signal updated successfully.")
        |> render("show_signal.html", signal: signal)


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit_signal.html", signal: signal, changeset: changeset)
    end
  end

  def add_like(conn, params) do
    signal = DataSignals.get_signal(params["id"])
    comments = DataSignals.get_comment_signal_id(params["id"])
    xaa = Enum.find(conn.assigns.current_user.liked_signals, fn(elem) -> elem == to_string(signal.id) end)
    if xaa == nil do 
      user_id = conn.assigns.current_user.id
      sup = Map.get(signal, :support_count)
      IO.inspect sup
      signal_params = %{support_count: sup+1}
      IO.inspect signal_params
      IO.puts "---->"
      IO.inspect signal.id
      IO.inspect user_id
      DataUsers.add_liked_signal(user_id, signal.id)
      case DataSignals.update_signal(signal, signal_params) do
      
        {:ok, signal} ->
         conn
          |> render("show_signal.html", signal: signal, comments: comments)
        {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "show_signal_no_like.html.html", signal: signal, changeset: changeset)
        end

    IO.puts "^^^^^^^^^^^"
   end
   render("show_signal.html", signal: signal, comments: comments)
   IO.puts "-------------"
  end

  def add_comment_like(conn, params) do
    comment = DataSignals.get_signal_comment(params["id"])
    IO.inspect comment
    signal = DataSignals.get_signal(params["signal_id"])
    xaa = Enum.find(conn.assigns.current_user.liked_comments, fn(elem) -> elem == to_string(comment.id) end)
    # xaa2 = Enum.find(conn.assigns.current_user.disliked_comments, fn(elem) -> elem == to_string(comment.id) end)
#     IO.inspect xaa
#     IO.inspect xaa2
#     if xaa2 != nil do ##if the comment was disliked before
#      om =  conn.assigns.current_user.id |> DataUsers.get_user! |> Map.get(:disliked_comments)
#      IO.puts "0000000000000000000000000000000000000000000"
#      IO.inspect om
#      IO.puts "0000000000000000000000000000000000000000000"
#     om =  om |> List.delete(to_string(comment.id))
#     user =  conn.assigns.current_user.id |> DataUsers.get_user! 
#     user_change = %{disliked_comments: om}
#     sup = Map.get(comment, :likes_number)
#     signal_params = %{likes_number: sup+1}
#     DataUsers.add_liked_signal_comment(user.id, comment.id)
#    ## comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
#     IO.inspect comment
#     IO.inspect signal_params
#     case DataSignals.update_signal_comment(comment, signal_params) do
#       {:ok, comment} ->
#       all_comments = DataSignals.get_comment_signal_id(signal.id)           
#       IO.inspect all_comments                                                             
#          conn
#           |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
#           {:error, %Ecto.Changeset{} = changeset} ->
#             render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
#           end
#  ## conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:liked_comments) 
#   ## DataUsers.update_user(user, user_change)
#     end
    if xaa == nil do 
      user_id = conn.assigns.current_user.id
      sup = Map.get(comment, :likes_number)
      signal_params = %{likes_number: sup+1}
      DataUsers.add_liked_signal_comment(user_id, comment.id)
      comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
      case DataSignals.update_signal_comment(comment, signal_params) do
      {:ok, comment} ->
        IO.puts "------------------------------"
        all_comments2 = DataSignals.get_comment_signal_id(signal.id) |> Enum.find(fn(x) -> if x.id == comment.id  do x =  x |> DataSignals.update_signal_comment(signal_params) end end) 
        all_comments = DataSignals.get_comment_signal_id(signal.id)                            
        IO.inspect all_comments                                                  
         conn
          |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect changeset
          render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
       end
       IO.inspect comment
       render(conn, "show_signal_no_comment_like.html", signal: signal, comments: comment)
     end
     IO.puts ":::::::::::::::::::::::::::::::::::::::::"
     IO.inspect comment
   render(conn, "show_signal_no_comment_like.html", signal: signal, comments: [comment])
  end

  def add_comment_dislike(conn, params) do
    comment = DataSignals.get_signal_comment(params["id"])
    signal = DataSignals.get_signal(params["signal_id"])
    xaa = Enum.find(conn.assigns.current_user.disliked_comments, fn(elem) -> elem == to_string(comment.id) end)
#     xaa2 = Enum.find(conn.assigns.current_user.liked_comments, fn(elem) -> elem == to_string(comment.id) end)
#     IO.inspect xaa
#     IO.inspect xaa2
#     if xaa2 != nil do ##if the comment was liked before
#      om =  conn.assigns.current_user.id |> DataUsers.get_user! |> Map.get(:liked_comments)
#      IO.puts "0000000000000000000000000000000000000000000"
#      IO.inspect om
#      IO.puts "0000000000000000000000000000000000000000000"
#     om =  om |> List.delete(to_string(comment.id))
#     user =  conn.assigns.current_user.id |> DataUsers.get_user! 
#     user_change = %{liked_comments: om}
#     sup = Map.get(comment, :likes_number)
#     signal_params = %{likes_number: sup-1}
#     DataUsers.add_disliked_signal_comment(user.id, comment.id)
#    ## comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
#     IO.inspect comment
#     IO.inspect signal_params
#     case DataSignals.update_signal_comment(comment, signal_params) do
#       {:ok, comment} ->
#       all_comments = DataSignals.get_comment_signal_id(signal.id)           
#       IO.inspect all_comments                                                             
#          conn
#           |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
#           {:error, %Ecto.Changeset{} = changeset} ->
#             render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
#           end
#  ## conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:liked_comments) 
#   ## DataUsers.update_user(user, user_change)
#     end
    if xaa == nil do 
      user_id = conn.assigns.current_user.id
      sup = Map.get(comment, :likes_number)
      signal_params = %{likes_number: sup-1}
      DataUsers.add_disliked_signal_comment(user_id, comment.id)
      comment = comment |> Map.delete(:likes_number) |> Map.merge(signal_params)
      conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:liked_comments) 
      case DataSignals.update_signal_comment(comment, signal_params) do
      {:ok, comment} ->
        all_comments2 = DataSignals.get_comment_signal_id(signal.id) |> Enum.find(fn(x) -> if x.id == comment.id  do x =  x |> DataSignals.update_signal_comment(signal_params) end end) 
        all_comments = DataSignals.get_comment_signal_id(signal.id)                                                                        
         conn
          |> render("show_signal_no_comment_like.html", signal: signal, comments: all_comments)
      {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "show_signal_no_like.html.html", signal: signal, comments: changeset)
       end
       render(conn, "show_signal_no_comment_like.html", signal: signal, comments: comment)
     end
     comment = DataSignals.list_signal_comment
   render(conn, "show_signal_no_comment_like.html", signal: signal, comments: comment)
  end



  def followed_signals(conn, params) do
    user_like = conn.assigns.current_user.liked_signals
    all_followed_signals = 
    Enum.map user_like, fn elem -> 
      String.to_integer(elem) |> DataSignals.get_signal   
    end
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

  def comment(conn, %{"show-comment" => show_comment, "show-id" => show_id}) do
    user_id = conn.assigns.current_user.id

    Smartcitydogs.DataSignals.create_signal_comment(%{
      comment: show_comment,
      signals_id: show_id,
      users_id: user_id
    })

    # redirect conn, to: "/signals/#{show_id}"
    render("show_signal.html")
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _signal} = DataSignals.delete_signal(id)

    conn
    |> put_flash(:info, "Signal deleted successfully.")
    |> redirect(to: signal_path(conn, :index))
  end
end
