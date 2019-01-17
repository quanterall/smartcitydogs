defmodule SmartcitydogsWeb.SignalLikeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalLikeControllerAPIView

  def render("index.json", %{signal_likes: signal_likes}) do
    %{data: render_many(signal_likes, SignalLikeControllerAPIView, "signal_like.json")}
  end

  def render("show.json", %{signal_like: signal_like}) do
    %{data: render_one(signal_like, SignalLikeControllerAPIView, "signal_like.json")}
  end

  def render("signal_like.json", %{signal_like_controller_api: signal_like}) do
    %{
      id: signal_like.id,
      like: signal_like.like,
      deleted_at: signal_like.deleted_at,
      signal_id: signal_like.signal_id,
      user_id: signal_like.user_id
    }
  end
end
