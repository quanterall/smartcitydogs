defmodule SmartCityDogsWeb.SignalsLikeController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.SignalsLikes
  alias SmartCityDogs.SignalsLikes.SignalsLike

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    signals_likes = SignalsLikes.list_signals_likes()
    render(conn, "index.json", signals_likes: signals_likes)
  end

  def create(conn, %{"signals_like" => signals_like_params}) do
    with {:ok, %SignalsLike{} = signals_like} <- SignalsLikes.create_signals_like(signals_like_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signals_like_path(conn, :show, signals_like))
      |> render("show.json", signals_like: signals_like)
    end
  end

  def show(conn, %{"id" => id}) do
    signals_like = SignalsLikes.get_signals_like!(id)
    render(conn, "show.json", signals_like: signals_like)
  end

  def update(conn, %{"id" => id, "signals_like" => signals_like_params}) do
    signals_like = SignalsLikes.get_signals_like!(id)

    with {:ok, %SignalsLike{} = signals_like} <- SignalsLikes.update_signals_like(signals_like, signals_like_params) do
      render(conn, "show.json", signals_like: signals_like)
    end
  end

  def delete(conn, %{"id" => id}) do
    signals_like = SignalsLikes.get_signals_like!(id)
    with {:ok, %SignalsLike{}} <- SignalsLikes.delete_signals_like(signals_like) do
      send_resp(conn, :no_content, "")
    end
  end
end
