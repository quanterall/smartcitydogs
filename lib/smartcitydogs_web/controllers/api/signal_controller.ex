defmodule SmartcitydogsWeb.SignalControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Signal
  alias Smartcitydogs.DataSignal
  alias Smartcitydogs.DataUsers
  alias Smartcitydogs.Repo
  action_fallback(SmartcitydogsWeb.FallbackController)

  plug(:put_layout, false when action in [:minicipality_signals])
  plug(:put_layout, false when action in [:minicipality_registered])
  plug(:put_layout, false when action in [:minicipality_adopted])
  plug(:put_layout, false when action in [:minicipality_shelter])
  plug(:put_layout, false when action in [:new])

  def index(conn, _params) do
    signals =
      Repo.all(Signal)
      |> Repo.preload([
        :user,
        :signal_images,
        :signal_comments,
        :signal_category,
        :signal_type
      ])
      |> SmartcitydogsWeb.Encoder.struct_to_map()

    json(conn, signals)
  end

  def show(conn, %{"id" => id}) do
    signal =
      Repo.get(Signal, id)
      |> Repo.preload([
        :user,
        :signal_images,
        :signal_comments,
        :signal_category,
        :signal_type
      ])
      |> SmartcitydogsWeb.Encoder.struct_to_map()

    json(conn, signal)
  end

  def create(conn, params) do
    #  a = conn.assigns.current_user.id
    user_id = conn.private.plug_session["current_user_id"]
    IO.inspect(params)

    signal_params =
      params
      |> Map.put("signal_type_id", 1)
      |> Map.put("signal_category_id", 1)
      |> Map.put("view_count", 0)
      |> Map.put("support_count", 0)
      |> Map.put("user_id", user_id)

    signal = DataSignal.create_signal(signal_params)
    images = Map.get(params, "images")

    if images do
      for n <- images do
        extension = Path.extname(n.filename)

        File.cp(
          n.path,
          File.cwd!() <> "/priv/static/images/#{Map.get(n, :filename)}-profile#{extension}"
        )

        args = %{
          "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
          "signal_id" => "#{signal.id}"
        }

        DataSignal.create_signal_images(args)
      end
    end

    redirect(conn, to: signal_controller_api_path(conn, :show, signal))

    # redirect(conn, to: signal_path(conn, :show, signal))
  end

  def update(conn, %{"id" => id, "signal" => signal_params}) do
    # if id == "follow" do
    #   SmartcitydogsWeb.SignalControllerAPI.follow(conn, %{"id" => signal_params})
    # end
    # if id == "unfollow" do
    #   SmartcitydogsWeb.SignalControllerAPI.unfollow(conn, %{"id" => signal_params})
    # end
    signal = DataSignal.get_signal(id)

    with {:ok, %Signal{} = signal} <- DataSignal.update_signal(signal, signal_params) do
      render(conn, "show.json", signal: signal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Signal{}} <- DataSignal.delete_signal(id) do
      send_resp(conn, :no_content, "")
    end
  end

  # def follow(conn, %{"id" => id}) do
  #   id = String.to_integer(id)
  #   user_id = conn.private.plug_session["current_user_id"]
  #   user_liked_signals = DataUsers.get_user!(user_id) |> Map.get(:liked_signals)
  #   cond do
  #     Enum.member?(user_liked_signals, id) ->
  #       signal = DataSignal.get_signal(id)
  #       render(conn, "already_followed.json", signal: signal)
  #     Enum.member?(user_liked_signals, id) == false ->
  #         DataUsers.add_like(user_id, id)
  #        {:ok, signal} = DataSignal.follow_signal(id)
  #         render(conn, "followed.json", signal: signal)
  #   end
  # end

  # def unfollow(conn, %{"id" => id}) do
  #   id = String.to_integer(id)
  #   user_id = conn.private.plug_session["current_user_id"]
  #   user_liked_signals = DataUsers.get_user!(user_id) |> Map.get(:liked_signals)
  #   cond do
  #     Enum.member?(user_liked_signals, id) ->
  #       DataUsers.remove_liked_signal(user_id, id)
  #       {:ok, signal} = DataSignal.unfollow_signal(id)
  #       render(conn, "unfollowed.json", signal: signal)

  #     Enum.member?(user_liked_signals, id) == false ->
  #       signal = DataSignal.get_signal(id)
  #       render(conn, "already_unfollowed.json", signal: signal)
  #   end
  # end

  def like(conn, params) do
    user_id = conn.private.plug_session["current_user_id"]
    signal = DataSignal.get_signal(params["id"])
    DataUsers.add_like(user_id, signal.id)

    conn
    |> json(%{new_count: DataUsers.get_likes(signal.id)})
  end

  def unlike(conn, map) do
    show_id = String.to_integer(map["id"])
    signal = DataSignal.get_signal(show_id)

    user_id = conn.private.plug_session["current_user_id"]
    DataUsers.remove_like(user_id, signal.id)

    conn
    |> json(%{new_count: DataUsers.get_likes(signal.id)})
  end

  def comment(conn, map) do
    show_comment = map["show-comment"]
    show_id = String.to_integer(map["show-id"])
    user_id = conn.private.plug_session["current_user_id"]

    Smartcitydogs.DataSignal.create_signal_comment(%{
      comment: show_comment,
      signal_id: show_id,
      user_id: user_id
    })

    comments = Smartcitydogs.DataSignal.get_comment_signal_id(show_id)
    signal = Smartcitydogs.DataSignal.get_signal(show_id)
    sorted_comments = Smartcitydogs.DataSignal.sort_signal_comment_by_id()

    redirect(conn,
      to:
        signal_path(conn, :show, signal, %{
          "comments" => comments,
          "sorted_comments" => sorted_comments
        })
    )
  end
end
