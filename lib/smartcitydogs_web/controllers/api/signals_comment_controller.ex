defmodule SmartcitydogsWeb.SignalsCommentControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalsComments
  alias Smartcitydogs.DataSignals

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

  def like(conn, %{"id" => id}) do
  
  end





end
