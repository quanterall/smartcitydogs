defmodule SmartcitydogsWeb.SignalControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalControllerAPIView

  def render("index.json", %{signals: signals}) do
    %{data: render_many(signals, SignalControllerAPIView, "signals.json")}
  end

  def render("show.json", %{signal: signal, comments: [sorted_comments], comments_count: _}) do
    %{
      data:
        render_one(
          %{signal: signal, comments: sorted_comments},
          SignalControllerAPIView,
          "signal_show.json"
        )
    }
  end

  def render("signals.json", %{signal_controller_api: signal}) do
    %{
      id: signal.id,
      title: signal.title,
      view_count: signal.view_count,
      address: signal.address,
      support_count: signal.support_count,
      chip_number: signal.chip_number,
      description: signal.description,
      deleted_at: signal.deleted_at,
      signal_type_id: signal.signal_type_id,
      signal_category_id: signal.signal_category_id,
      user_id: signal.user_id
    }
  end

  def render("signal_show.json", %{signal_controller_api: signal}) do
    %{
      id: signal.signal.id,
      title: signal.signal.title,
      view_count: signal.signal.view_count,
      address: signal.signal.address,
      support_count: signal.signal.support_count,
      chip_number: signal.signal.chip_number,
      description: signal.signal.description,
      deleted_at: signal.signal.deleted_at,
      signal_type_id: signal.signal.signal_type_id,
      signal_category_id: signal.signal.signal_category_id,
      user_id: signal.signal.user_id,
      comments_id: signal.comments.id,
      comments_comment: signal.comments.comment,
      comments_insert: signal.comments.inserted_at,
      comments_like: signal.comments.likes_number,
      comments_user_first_name: signal.comments.users.first_name,
      comments_user_last_name: signal.comments.users.last_name,
      comments_users_id: signal.comments.user_id
    }
  end

  def render("followed.json", %{signal: signal}) do
    %{
      id: signal.id,
      title: signal.title,
      view_count: signal.view_count,
      address: signal.address,
      support_count: signal.support_count,
      chip_number: signal.chip_number,
      description: signal.description,
      deleted_at: signal.deleted_at,
      signal_type_id: signal.signal_type_id,
      signal_category_id: signal.signal_category_id,
      user_id: signal.user_id
    }
  end

  def render("already_followed.json", %{signal: _}) do
    %{error: "Signal has already been followed."}
  end

  def render("unfollowed.json", %{signal: signal}) do
    %{
      id: signal.id,
      title: signal.title,
      view_count: signal.view_count,
      address: signal.address,
      support_count: signal.support_count,
      chip_number: signal.chip_number,
      description: signal.description,
      deleted_at: signal.deleted_at,
      signal_type_id: signal.signal_type_id,
      signal_category_id: signal.signal_category_id,
      user_id: signal.user_id
    }
  end

  def render("already_unfollowed.json", %{signal: _}) do
    %{error: "Signal has already been unfollowed."}
  end
end
