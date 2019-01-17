defmodule SmartcitydogsWeb.SignalsLikeControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalsLikes
  alias Smartcitydogs.DataSignals

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signal_likes = DataSignals.list_signal_like()
    render(conn, "index.json", signal_likes: signal_likes)
  end

  def create(conn, %{"signals_like" => signals_like_params}) do
    with {:ok, %SignalsLikes{} = signals_like} <-
           DataSignals.create_signal_like(signals_like_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signals_like_controller_api_path(conn, :show, signals_like))
      |> render("show.json", signals_like: signals_like)
    end
  end

  def show(conn, %{"id" => id}) do
    signals_like = DataSignals.get_signal_like(id)
    render(conn, "show.json", signals_like: signals_like)
  end

  def update(conn, %{"id" => id, "signals_like" => signals_like_params}) do
    signals_like = DataSignals.get_signal_like(id)

    with {:ok, %SignalsLikes{} = signals_like} <-
           DataSignals.update_signal_like(signals_like, signals_like_params) do
      render(conn, "show.json", signals_like: signals_like)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalsLikes{}} <- DataSignals.delete_signal_like(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
