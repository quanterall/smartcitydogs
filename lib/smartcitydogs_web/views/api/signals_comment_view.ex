defmodule SmartcitydogsWeb.SignalsCommentControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalsCommentControllerAPIView

  def render("index.json", %{signals_comments: signals_comments}) do
    %{
      data: render_many(signals_comments, SignalsCommentControllerAPIView, "signals_comment.json")
    }
  end

  def render("show.json", %{signals_comment: signals_comment}) do
    %{data: render_one(signals_comment, SignalsCommentControllerAPIView, "signals_comment.json")}
  end

  def render("signals_comment.json", %{signals_comment_controller_api: signals_comment}) do
    %{
      id: signals_comment.id,
      comment: signals_comment.comment,
      deleted_at: signals_comment.deleted_at,
      signals_id: signals_comment.signals_id,
      users_id: signals_comment.users_id
    }
  end

  def render("followed.json", %{signal_comment: signals_comment}) do
    %{
      id: signals_comment.id,
      comment: signals_comment.comment,
      deleted_at: signals_comment.deleted_at,
      signals_id: signals_comment.signals_id,
      users_id: signals_comment.users_id
    }
  end

  def render("already_followed.json", %{signal_comment: _}) do
    %{error: "Signal comment has already been liked."}
  end



  def render("unfollowed.json", %{signal_comment: signals_comment}) do
    %{
      id: signals_comment.id,
      comment: signals_comment.comment,
      deleted_at: signals_comment.deleted_at,
      signals_id: signals_comment.signals_id,
      users_id: signals_comment.users_id
    }
  end

  def render("already_unfollowed.json", %{signal_comment: _}) do
    %{error: "Signal comment has already been disliked."}
  end

  def render("not_found.json", %{signal_comment: _}) do
    %{error: "Signal comment not found."}
  end
end
