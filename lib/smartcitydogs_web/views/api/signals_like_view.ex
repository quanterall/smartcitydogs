defmodule SmartcitydogsWeb.SignalsLikeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalsLikeControllerAPIView

  def render("index.json", %{signals_likes: signals_likes}) do
    %{data: render_many(signals_likes, SignalsLikeControllerAPIView, "signals_like.json")}
  end

  def render("show.json", %{signals_like: signals_like}) do
    %{data: render_one(signals_like, SignalsLikeControllerAPIView, "signals_like.json")}
  end

  def render("signals_like.json", %{signals_like_controller_api: signals_like}) do
    %{
      id: signals_like.id,
      like: signals_like.like,
      deleted_at: signals_like.deleted_at,
      signals_id: signals_like.signals_id,
      users_id: signals_like.users_id
    }
  end
end
