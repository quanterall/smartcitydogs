defmodule SmartcitydogsWeb.SignalsLikeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalsLikeControllerAPIView

  def render("index.json", %{signal_likes: signal_likes}) do
    %{data: render_many(signal_likes, SignalsLikeControllerAPIView, "signals_like.json")}
  end

  def render("show.json", %{signals_like: signals_like}) do
    %{data: render_one(signals_like, SignalsLikeControllerAPIView, "signals_like.json")}
  end

  def render("signals_like.json", %{signals_like_controller_api: signals_like}) do
    %{
      id: signals_like.id,
      like: signals_like.like,
      deleted_at: signals_like.deleted_at,
      signal_id: signals_like.signal_id,
      user_id: signals_like.user_id
    }
  end
end
