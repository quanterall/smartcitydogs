defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Repo
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Repo
  alias Smartcitydogs.Animals
  alias SmartcitydogsWeb.SignalController
  import Ecto.Query

  # plug(:put_layout, false when action in [:filter_index])
  # plug(:put_layout, false when action in [:filter_animals])
  # plug(:put_layout, false when action in [:new])

  action_fallback(SmartCityDogsWeb.FallbackController)


  ##Hanlde regular user page
  def index(conn, params) do
    if params == %{} do
      x = 1
    else
      x = String.to_integer(params["page"])
    end

    sorted_signals = DataSignals.sort_signal_by_id()
    page = Smartcitydogs.Repo.paginate(sorted_signals, page: x, page_size: 8)
    render(conn, "index2_signal.html", signal: page.entries, page: page)
  end





  #All signals page with the checkbox filters, function for the first rendering
  def minicipality_signals(conn, params) do
     data_status = 
     case Map.fetch(params, "page") do
        {:ok, num} -> {params["data_status"], params["data_category"], num}
        _ -> {[], "1"}
     end
     SignalController.get_ticked_checkboxes(conn, data_status)
  data_category =  
      for  {k , v}  <- params do
        cond do 
          k |> String.match?( ~r/sig_category./) && v != "false" -> 
          v   
          true ->
          nil
        end
    end
    data_status = 
    for  {k , v}  <- params do
      cond do 
        k |> String.match?( ~r/sig_status./) && v != "false" ->
        v   
        true ->
          nil
       end
    end
    data_category = Enum.filter(data_category, & !is_nil(&1))
    data_status = Enum.filter(data_status, & !is_nil(&1))
    cond do
      data_category != []->
        all_query = []
        x =
          Enum.map(data_category, fn x ->
            struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))
            all_query = all_query ++ Repo.all(struct)
          end)
        x = List.flatten(x)
        page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
        render(conn, "minicipality_signals.html", signal: page.entries, page: page, data: nil)
      data_status != [] ->
        all_query = []

        x =
          Enum.map(data_status, fn x ->
            struct = from(p in Signals, where: p.signals_types_id == ^String.to_integer(x))
            all_query = all_query ++ Repo.all(struct)
          end)         
        x = List.flatten(x)
        page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
        render(conn, "minicipality_signals.html", signal: page.entries, page: page, data: nil)
    end
  end

  ##When the search button is clicked, for rendering the first page of the query.
  def filter_signals(conn, params) do
    data_status =  
      for  {k , v}  <- params do
        cond do 
          k |> String.match?( ~r/sig_status./) && v != "false" -> 
            v   
          true ->
            nil
        end
      end
    data_category =  
      for  {k , v}  <- params do
      cond do 
        k |> String.match?( ~r/sig_category./) && v != "false" -> ##do
        v   
        true ->
          nil
       end
    end
    data_category = Enum.filter(data_category, & !is_nil(&1))
    data_status = Enum.filter(data_status, & !is_nil(&1))
    cond do
      data_status != []->
        all_query = []
        x =
        Enum.map(data_status, fn x ->
          struct = from(p in Signals, where: p.signals_types_id == ^String.to_integer(x))
          all_query = all_query ++ Repo.all(struct)
        end)
          page = Smartcitydogs.Repo.paginate( List.flatten(x) , page: 1, page_size: 8)
          render(conn, "minicipality_signals.html", signal: page.entries, page: page, data_status: data_status, data_category: data_category)
      data_category != []->
            all_query = []
            x =
              Enum.map(data_category, fn x ->
                struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))
                all_query = all_query ++ Repo.all(struct)
              end)
            x = List.flatten(x)
            page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
           render(conn, "minicipality_signals.html", signal: page.entries, page: page, data_category: data_category, data_status: data_status)    
      true -> 
        x = DataSignals.list_signals()
        page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
        render(conn, "minicipality_signals.html", signal: page.entries, page: page, data_status: data_status, data_category: data_category)
    end
  end

  ##Get all of the ticked checkboxes from the filters, handle redirection to pagination pages.
  def get_ticked_checkboxes(conn, params) do
    {data_status, data_category, num} = params
    num = String.to_integer(num)
    cond do
      data_status != []->
        all_query = []
        x =
        Enum.map(data_status, fn x ->
          struct = from(p in Signals, where: p.signals_types_id == ^String.to_integer(x))
          all_query = all_query ++ Repo.all(struct)
        end)
     x = List.flatten(x)
        list_signals = Smartcitydogs.Repo.paginate(x, page: num, page_size: 8)
       render(conn, "minicipality_signals.html", signal: list_signals.entries, page: list_signals,  data_category: data_category, data_status: data_status)
     data_category != []->
      all_query = []

      x =
        Enum.map(data_category, fn x ->
          struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))
          all_query = all_query ++ Repo.all(struct)
        end)

      x = List.flatten(x)
      page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
     render(conn, "minicipality_signals.html", signal: page.entries, page: page, data_category: data_category, data_status: data_status)    
     true ->
        x = DataSignals.list_signals()
        page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
        render(conn, "minicipality_signals.html", signal: page.entries, page: page, data_category: data_category, data_status: data_status)
      end
  end





  
  # def index_home_minicipality(conn, params) do
  #   page = Signals |> Smartcitydogs.Repo.paginate(params)
  #   render(conn, "filter_index.html", signal: page.entries, page: page)
  # end

  def new(conn, _params) do
    changeset = Smartcitydogs.DataSignals.change_signal(%Signals{})

    logged_user_type_id = conn.assigns.current_user.users_types.id

    if logged_user_type_id == 4 || logged_user_type_id == 2 do
      render(conn, "new_signal.html", changeset: changeset)
    else
      render(conn, SmartcitydogsWeb.ErrorView, "401.html")
    end
  end

  def create(conn, signal_params) do
    signals_categories_id = String.to_integer(signal_params["signals_categories_id"])
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

  def show(conn, map) do
    IO.inspect map
    id = map["id"]
    cond do 
      id == "remove_like" ->
        remove_like(conn,map)
      id == "update_like_count" ->
        update_like_count(conn,map)
      id == "comment" ->
        comment(conn,map)
      true ->
        id = String.to_integer(map["id"])
        comments = DataSignals.get_comment_signal_id(id)
        signal = DataSignals.get_signal(id)
        ## signal is liked by user
        sorted_comments = DataSignals.sort_signal_comment_by_id()
          render(
            conn,
            "show_signal.html",
            signal: signal,
            comments: sorted_comments,
            comments_count: comments
          )
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

  def get_signals_support_count_minus(signal_id) do
    list = Smartcitydogs.DataSignals.get_signal_support_count(signal_id)

    if list != [] do
      [head | tail] = list
      count = head.support_count
      Smartcitydogs.DataSignals.update_signal(head, %{support_count: count - 1})
    end

    head.support_count - 1
  end

  def remove_like(conn, map) do
    show_id = String.to_integer(map["show-id"])
    signal = DataSignals.get_signal(show_id)
    
    user_id = conn.assigns.current_user.id
    DataUsers.remove_liked_signal(user_id, show_id)
    count = get_signals_support_count_minus(show_id)

    conn
    |> json(%{new_count: count})
  end

  def update_like_count(conn, map) do
    IO.inspect map
    show_count = String.to_integer(map["show-count"])
    show_id = String.to_integer(map["show-id"])
    signal = DataSignals.get_signal(show_id)
    user_id = conn.assigns.current_user.id
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

  def comment(conn,map) do
    IO.puts "MAP______________________________________"
    IO.inspect map 
    show_comment = map["show-comment"]
    show_id = String.to_integer(map["show-id"])
    user_id = conn.assigns.current_user.id

    Smartcitydogs.DataSignals.create_signal_comment(%{
      comment: show_comment,
      signals_id: show_id,
      users_id: user_id
    })

      comments = DataSignals.get_comment_signal_id(show_id)
      signal = DataSignals.get_signal(show_id)
      sorted_comments = DataSignals.sort_signal_comment_by_id()
        render(
          conn,
          "show_signal.html",
          signal: signal,
          comments: sorted_comments,
          comments_count: comments
        )

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
  
  # def filter_animals(conn, params) do
  #   IO.puts "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
  #  ## IO.inspect filter_animals
  #   if params == %{} do
  #     x = DataAnimals.list_animals()
  #     page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
  #     render(conn, "filter_animals.html", animals: x, page: page)
  #   end
  
  #   params = Map.values(params)
  #   [inner_map] = params
  #   inner_map = Map.values(inner_map)
  #   [id] = inner_map
  #   all_query = []
  
  #   x =
  #     Enum.map(id, fn x ->
  #       struct = from(p in Animals, where: p.animals_status_id == ^String.to_integer(x))
  #       all_query = (all_query ++ Repo.all(struct)) |> Repo.preload(:animals_status)
  #     end)
  
  #   x = List.flatten(x)
  #   page = Smartcitydogs.Repo.paginate(x, page: 1, page_size: 8)
  #   render(conn, "filter_animals.html", animals: x, page: page)
  # end


end


