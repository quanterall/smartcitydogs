defmodule SmartcitydogsWeb.Api.SignalCommentController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalComment
  alias Smartcitydogs.Guardian

  def create(conn, %{"signal_id" => signal_id, "signal_comment" => comment_params}) do
    %{id: id} = Guardian.Plug.current_resource(conn)

    {:ok, comment} =
      comment_params
      |> Map.put("user_id", id)
      |> Map.put("signal_id", signal_id)
      |> SignalComment.create()

    json(conn, SmartcitydogsWeb.Encoder.struct_to_map(comment))
  end
end
