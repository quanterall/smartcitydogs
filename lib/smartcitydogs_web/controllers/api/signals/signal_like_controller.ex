defmodule SmartcitydogsWeb.Api.SignalLikeController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalLike
  alias Smartcitydogs.Guardian

  def create(conn, %{"signal_id" => signal_id}) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)

    {:ok, like} =
      %{"user_id" => user_id, "signal_id" => signal_id}
      |> SignalLike.create()

    json(conn, SmartcitydogsWeb.Encoder.struct_to_map(like))
  end

  def delete(conn, %{"id" => like_id}) do
    %{user_id: user_id} = SignalLike.get(like_id)
    %{id: logged_user_id} = Guardian.Plug.current_resource(conn)

    if logged_user_id == user_id do
      {:ok, _} = SignalLike.delete(like_id)
      json(conn, %{status: :success})
    else
      json(conn, %{status: :failed})
    end
  end
end
