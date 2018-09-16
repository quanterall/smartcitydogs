defmodule SmartcitydogsWeb.SignalsCommentController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.{SignalsComments, Repo}

  action_fallback(SmartcitydogsWeb.FallbackController)

  def create(conn, %{"id" => id, "comment" => comment}) do
    data = %{signals_id: id, comment: comment, users_id: conn.assigns.current_user.id}

    %SignalsComments{}
    |> SignalsComments.changeset(data)
    |> Repo.insert!()

    redirect(conn, to: signal_path(conn, :show, id))
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalsComments{}} <- DataSignals.delete_signal_comment(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
