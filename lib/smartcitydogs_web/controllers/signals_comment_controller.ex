defmodule SmartCityDogsWeb.SignalsCommentController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.SignalsComments
  alias SmartCityDogs.SignalsComments.SignalsComment

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    signals_comments = SignalsComments.list_signals_comments()
    render(conn, "index.json", signals_comments: signals_comments)
  end

  def create(conn, %{"signals_comment" => signals_comment_params}) do
    with {:ok, %SignalsComment{} = signals_comment} <- SignalsComments.create_signals_comment(signals_comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signals_comment_path(conn, :show, signals_comment))
      |> render("show.json", signals_comment: signals_comment)
    end
  end

  def show(conn, %{"id" => id}) do
    signals_comment = SignalsComments.get_signals_comment!(id)
    render(conn, "show.json", signals_comment: signals_comment)
  end

  def update(conn, %{"id" => id, "signals_comment" => signals_comment_params}) do
    signals_comment = SignalsComments.get_signals_comment!(id)

    with {:ok, %SignalsComment{} = signals_comment} <- SignalsComments.update_signals_comment(signals_comment, signals_comment_params) do
      render(conn, "show.json", signals_comment: signals_comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    signals_comment = SignalsComments.get_signals_comment!(id)
    with {:ok, %SignalsComment{}} <- SignalsComments.delete_signals_comment(signals_comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
