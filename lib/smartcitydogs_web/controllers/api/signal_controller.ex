defmodule SmartcitydogsWeb.SignalControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Signals
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.DataUsers

  action_fallback(SmartcitydogsWeb.FallbackController)

  plug(:put_layout, false when action in [:minicipality_signals])
  plug(:put_layout, false when action in [:minicipality_registered])
  plug(:put_layout, false when action in [:minicipality_adopted])
  plug(:put_layout, false when action in [:minicipality_shelter])
  plug(:put_layout, false when action in [:new])

  def index(conn, _params) do
    signals = DataSignals.list_signals()
    render(conn, "index.json", signals: signals)
  end

  def create(conn, %{"signal" => signal_params}) do
    with {:ok, %Signals{} = signal} <- DataSignals.create_signal(signal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_path(conn, :show, signal))
      |> render("show.json", signal: signal)
    end
  end

  def show(conn, %{"id" => id}) do
    signal = DataSignals.get_signal(id)
    render(conn, "show.json", signal: signal)
  end

  def update(conn, %{"id" => id, "signal" => signal_params}) do
    if id == "follow" do
      SmartcitydogsWeb.SignalControllerAPI.follow(conn, %{"id" => signal_params})
    end
    if id == "unfollow" do
      SmartcitydogsWeb.SignalControllerAPI.unfollow(conn, %{"id" => signal_params})
    end
    signal = DataSignals.get_signal(id)

    with {:ok, %Signals{} = signal} <- DataSignals.update_signal(signal, signal_params) do
      render(conn, "show.json", signal: signal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Signals{}} <- DataSignals.delete_signal(id) do
      send_resp(conn, :no_content, "")
    end
  end


  def follow(conn, %{"id" => id}) do
    id = String.to_integer(id)
    user_id = conn.private.plug_session["current_user_id"]
    user_liked_signals = DataUsers.get_user!(user_id) |> Map.get(:liked_signals)
    cond do
      Enum.member?(user_liked_signals, id) -> 
        signal = DataSignals.get_signal(id)
        render(conn, "already_followed.json", signal: signal)
      Enum.member?(user_liked_signals, id) == false ->
          DataUsers.add_liked_signal(user_id, id)
         {:ok, signal} = DataSignals.follow_signal(id)
          render(conn, "followed.json", signal: signal)
    end 
  end

  def unfollow(conn, %{"id" => id}) do
    id = String.to_integer(id)
    user_id = conn.private.plug_session["current_user_id"]
    user_liked_signals = DataUsers.get_user!(user_id) |> Map.get(:liked_signals)
    cond do
      Enum.member?(user_liked_signals, id) -> 
        DataUsers.remove_liked_signal(user_id, id)
        {:ok, signal} = DataSignals.unfollow_signal(id)
        render(conn, "unfollowed.json", signal: signal)

      Enum.member?(user_liked_signals, id) == false ->
        signal = DataSignals.get_signal(id)
        render(conn, "already_unfollowed.json", signal: signal)
    end 
  end

  def like(conn, params) do

    user_id = conn.private.plug_session["current_user_id"]
    signal = DataSignals.get_signal(params["id"])
    DataUsers.add_like(user_id, signal.id)

    conn
    |> json(%{new_count: DataUsers.get_likes(signal.id)})

  end

  def unlike(conn, map) do
    show_id = String.to_integer(map["id"])
    signal = DataSignals.get_signal(show_id)
    
    user_id = conn.private.plug_session["current_user_id"]
    DataUsers.remove_like(user_id, signal.id)
    conn
    |> json(%{new_count: DataUsers.get_likes(signal.id)})
  end

  def comment(conn,map) do
    show_comment = map["show-comment"]
    show_id = String.to_integer(map["show-id"])
    user_id = conn.private.plug_session["current_user_id"]
    IO.inspect show_id, label: "SHOW_ID:"
    Smartcitydogs.DataSignals.create_signal_comment(%{
      comment: show_comment,
      signals_id: show_id,
      users_id: user_id
    })

      comments = Smartcitydogs.DataSignals.get_comment_signal_id(show_id)
      signal = Smartcitydogs.DataSignals.get_signal(show_id)
      sorted_comments = Smartcitydogs.DataSignals.sort_signal_comment_by_id()
      
      redirect(conn, to: signal_path(conn, :show, signal))

  end

end
