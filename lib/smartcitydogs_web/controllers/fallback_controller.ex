defmodule SmartcitydogsWeb.FallbackController do
  use SmartcitydogsWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:forbidden)
    |> render(SmartcitydogsWeb.ErrorView, :"403")
  end
end
