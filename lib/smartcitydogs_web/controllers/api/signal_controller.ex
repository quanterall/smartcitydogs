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
        :users,
        :signal_images,
        :signal_comments,
        :signal_category,
        :signal_type
      ])
      |> SmartcitydogsWeb.Encoder.encode()

    json(conn, signals)
  end

  def create(conn, %{"signal" => signal_params}) do
    #  a = conn.assigns.current_user.id
    user_id = conn.private.plug_session["current_user_id"]

    signal_params =
      signal_params
      |> Map.put("signal_type_id", 1)
      |> Map.put("view_count", 0)
      |> Map.put("support_count", 0)
      |> Map.put("user_id", user_id)

    case DataSignal.create_signal(signal_params) do
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
            "signal_id" => "#{signal.id}"
          }

          DataSignal.create_signal_images(args)
        end

        render("show.json", signal: signal)

      # redirect(conn, to: signal_path(conn, :show, signal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_signal.html", changeset: changeset)
    end

    # with {:ok, %Signal{} = signal} <- DataSignal.create_signal(signal_params) do
    #   conn
    #   |> put_status(:created)
    #   |> put_resp_header("location", signal_path(conn, :show, signal))
    #   |> render("show.json", signal: signal)
    # end
  end

  def show(conn, map) do
    id = String.to_integer(map["id"])
    comments = DataSignal.get_comment_signal_id(id)
    signal = DataSignal.get_signal(id)
    ## signal is liked by user
    sorted_comments = DataSignal.sort_signal_comment_by_id()

    render(
      conn,
      "show.json",
      signal: signal,
      comments: sorted_comments,
      comments_count: comments
    )
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
