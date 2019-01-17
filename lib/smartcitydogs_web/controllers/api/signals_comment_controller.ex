defmodule SmartcitydogsWeb.SignalCommentControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalComment
  alias Smartcitydogs.DataSignal

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signal_comments = DataSignal.list_signal_comment()
    render(conn, "index.json", signal_comments: signal_comments)
  end

  def create(conn, %{"signal_comment" => signal_comment_params}) do
    with {:ok, %SignalComment{} = signal_comment} <-
           DataSignal.create_signal_comment(signal_comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        signal_comment_controller_api_path(conn, :show, signal_comment)
      )
      |> render("show.json", signal_comment: signal_comment)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_comment = DataSignal.get_signal_comment(id)
    render(conn, "show.json", signal_comment: signal_comment)
  end

  def update(conn, %{"id" => id, "signal_comment" => signal_comment_params}) do
    signal_comment = DataSignal.get_signal_comment(id)

    with {:ok, %SignalComment{} = signal_comment} <-
           DataSignal.update_signal_comment(signal_comment, signal_comment_params) do
      render(conn, "show.json", signal_comment: signal_comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalComment{}} <- DataSignal.delete_signal_comment(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
