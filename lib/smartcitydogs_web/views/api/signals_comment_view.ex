defmodule SmartcitydogsWeb.SignalCommentControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalCommentControllerAPIView

  def render("index.json", %{signal_comments: signal_comments}) do
    %{
      data: render_many(signal_comments, SignalCommentControllerAPIView, "signal_comment.json")
    }
  end

  def render("show.json", %{signal_comment: signal_comment}) do
    %{data: render_one(signal_comment, SignalCommentControllerAPIView, "signal_comment.json")}
  end

  def render("signal_comment.json", %{signal_comment_controller_api: signal_comment}) do
    %{
      id: signal_comment.id,
      comment: signal_comment.comment,
      deleted_at: signal_comment.deleted_at,
      signal_id: signal_comment.signal_id,
      user_id: signal_comment.user_id
    }
  end

  def render("followed.json", %{signal_comment: signal_comment}) do
    %{
      id: signal_comment.id,
      comment: signal_comment.comment,
      deleted_at: signal_comment.deleted_at,
      signal_id: signal_comment.signal_id,
      user_id: signal_comment.user_id
    }
  end

  def render("already_followed.json", %{signal_comment: _}) do
    %{error: "Signal comment has already been liked."}
  end

  def render("unfollowed.json", %{signal_comment: signal_comment}) do
    %{
      id: signal_comment.id,
      comment: signal_comment.comment,
      deleted_at: signal_comment.deleted_at,
      signal_id: signal_comment.signal_id,
      user_id: signal_comment.user_id
    }
  end

  def render("already_unfollowed.json", %{signal_comment: _}) do
    %{error: "Signal comment has already been disliked."}
  end

  def render("not_found.json", %{signal_comment: _}) do
    %{error: "Signal comment not found."}
  end
end
