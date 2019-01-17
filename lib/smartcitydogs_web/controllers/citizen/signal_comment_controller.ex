defmodule SmartcitydogsWeb.SignalCommentController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.{SignalComment, Repo}

  action_fallback(SmartcitydogsWeb.FallbackController)

  def create(conn, %{"id" => id, "comment" => comment}) do
    data = %{signal_id: id, comment: comment, user_id: conn.assigns.current_user.id}

    %SignalComment{}
    |> SignalComment.changeset(data)
    |> Repo.insert!()

    redirect(conn, to: signal_path(conn, :show, id))
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalComment{}} <- DataSignal.delete_signal_comment(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
