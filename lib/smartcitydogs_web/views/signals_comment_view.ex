defmodule SmartCityDogsWeb.SignalsCommentView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.SignalsCommentView

  def render("index.json", %{signals_comments: signals_comments}) do
    %{data: render_many(signals_comments, SignalsCommentView, "signals_comment.json")}
  end

  def render("show.json", %{signals_comment: signals_comment}) do
    %{data: render_one(signals_comment, SignalsCommentView, "signals_comment.json")}
  end

  def render("signals_comment.json", %{signals_comment: signals_comment}) do
    %{id: signals_comment.id,
      comment: signals_comment.comment,
      deleted_at: signals_comment.deleted_at,
      signals_id: signals_comment.signals_id,
      users_id: signals_comment.users_id}
  end
end
