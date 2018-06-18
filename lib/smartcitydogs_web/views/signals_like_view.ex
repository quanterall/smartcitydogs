defmodule SmartCityDogsWeb.SignalsLikeView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.SignalsLikeView

  def render("index.json", %{signals_likes: signals_likes}) do
    %{data: render_many(signals_likes, SignalsLikeView, "signals_like.json")}
  end

  def render("show.json", %{signals_like: signals_like}) do
    %{data: render_one(signals_like, SignalsLikeView, "signals_like.json")}
  end

  def render("signals_like.json", %{signals_like: signals_like}) do
    %{id: signals_like.id,
      like: signals_like.like,
      deleted_at: signals_like.deleted_at,
      signals_id: signals_like.signals_id,
      users_id: signals_like.users_id}
  end
end
