defmodule SmartcitydogsWeb.SignalLikeControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalLikes
  alias Smartcitydogs.DataSignal

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signal_likes = DataSignal.list_signal_like()
    render(conn, "index.json", signal_likes: signal_likes)
  end

  def create(conn, %{"signal_like" => signal_like_params}) do
    with {:ok, %SignalLikes{} = signal_like} <-
           DataSignal.create_signal_like(signal_like_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_like_controller_api_path(conn, :show, signal_like))
      |> render("show.json", signal_like: signal_like)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_like = DataSignal.get_signal_like(id)
    render(conn, "show.json", signal_like: signal_like)
  end

  def update(conn, %{"id" => id, "signal_like" => signal_like_params}) do
    signal_like = DataSignal.get_signal_like(id)

    with {:ok, %SignalLikes{} = signal_like} <-
           DataSignal.update_signal_like(signal_like, signal_like_params) do
      render(conn, "show.json", signal_like: signal_like)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalLikes{}} <- DataSignal.delete_signal_like(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
