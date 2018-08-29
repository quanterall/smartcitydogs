defmodule SmartcitydogsWeb.SignalsCommentControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalsComments
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.DataUsers

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signals_comments = DataSignals.list_signal_comment()
    render(conn, "index.json", signals_comments: signals_comments)
  end

  def create(conn, %{"signals_comment" => signals_comment_params}) do
    with {:ok, %SignalsComments{} = signals_comment} <-
           DataSignals.create_signal_comment(signals_comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        signals_comment_controller_api_path(conn, :show, signals_comment)
      )
      |> render("show.json", signals_comment: signals_comment)
    end
  end

  def show(conn, %{"id" => id}) do
    signals_comment = DataSignals.get_signal_comment(id)
    render(conn, "show.json", signals_comment: signals_comment)
  end

  def update(conn, %{"id" => id, "signals_comment" => signals_comment_params}) do
    if id == "follow" do
      SmartcitydogsWeb.SignalsCommentControllerAPI.follow(conn, %{
        "data" => signals_comment_params
      })
    end

    if id == "unfollow" do
      SmartcitydogsWeb.SignalsCommentControllerAPI.unfollow(conn, %{
        "data" => signals_comment_params
      })
    end

    signals_comment = DataSignals.get_signal_comment(id)

    with {:ok, %SignalsComments{} = signals_comment} <-
           DataSignals.update_signal_comment(signals_comment, signals_comment_params) do
      render(conn, "show.json", signals_comment: signals_comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalsComments{}} <- DataSignals.delete_signal_comment(id) do
      send_resp(conn, :no_content, "")
    end
  end

  def follow(conn, %{"data" => %{"id" => id, "signals_id" => signals_id}}) do
    id = String.to_integer(id)
    user_id = conn.private.plug_session["current_user_id"]
    user_liked_comments = DataUsers.get_user!(user_id) |> Map.get(:liked_comments)
    user_disliked_comments = DataUsers.get_user!(user_id) |> Map.get(:disliked_comments)

    cond do
      Enum.member?(user_liked_comments, id) ->
        signal_comment = DataSignals.get_one_signal_comment(signals_id, id)

        if signal_comment == nil do
          render(conn, "not_found.json", signal_comment: signal_comment)
        end

        render(conn, "already_followed.json", signal_comment: signal_comment)

      Enum.member?(user_liked_comments, id) == false ->
        if Enum.member?(user_disliked_comments, id) do
          DataUsers.add_liked_signal_comment(user_id, id)
          DataUsers.remove_disliked_signal_comment(user_id, id)
          signal_comment = DataSignals.get_one_signal_comment(signals_id, id)
          signal_coment_old_like = signal_comment |> Map.get(:likes_number)

          {:ok, signal_comment} =
            signal_comment
            |> DataSignals.update_signal_comment(%{likes_number: signal_coment_old_like + 2})

          render(conn, "followed.json", signal_comment: signal_comment)
        else
          DataUsers.add_liked_signal_comment(user_id, id)
          signal_comment = DataSignals.get_one_signal_comment(signals_id, id)
          signal_coment_old_like = signal_comment |> Map.get(:likes_number)

          {:ok, signal_comment} =
            signal_comment
            |> DataSignals.update_signal_comment(%{likes_number: signal_coment_old_like + 1})

          render(conn, "followed.json", signal_comment: signal_comment)
        end
    end
  end

  def unfollow(conn, %{"data" => %{"id" => id, "signals_id" => signals_id}}) do
    id = String.to_integer(id)
    user_id = conn.private.plug_session["current_user_id"]
    user_liked_comments = DataUsers.get_user!(user_id) |> Map.get(:liked_comments)
    user_disliked_comments = DataUsers.get_user!(user_id) |> Map.get(:disliked_comments)

    cond do
      Enum.member?(user_disliked_comments, id) ->
        signal_comment = DataSignals.get_one_signal_comment(signals_id, id)

        if signal_comment == nil do
          render(conn, "not_found.json", signal_comment: signal_comment)
        end

        render(conn, "already_unfollowed.json", signal_comment: signal_comment)

      Enum.member?(user_disliked_comments, id) == false ->
        if Enum.member?(user_liked_comments, id) do
          DataUsers.remove_liked_signal_comment(user_id, id)
          DataUsers.add_disliked_signal_comment(user_id, id)
          signal_comment = DataSignals.get_one_signal_comment(signals_id, id)
          signal_coment_old_like = signal_comment |> Map.get(:likes_number)

          {:ok, signal_comment} =
            signal_comment
            |> DataSignals.update_signal_comment(%{likes_number: signal_coment_old_like - 2})

          render(conn, "unfollowed.json", signal_comment: signal_comment)
        else
          DataUsers.add_disliked_signal_comment(user_id, id)
          signal_comment = DataSignals.get_one_signal_comment(signals_id, id)
          signal_coment_old_like = signal_comment |> Map.get(:likes_number)

          {:ok, signal_comment} =
            signal_comment
            |> DataSignals.update_signal_comment(%{likes_number: signal_coment_old_like - 1})

          render(conn, "unfollowed.json", signal_comment: signal_comment)
        end
    end
  end
end
