defmodule SmartcitydogsWeb.FallbackController do
  use SmartcitydogsWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:forbidden)
    |> put_view(SmartcitydogsWeb.ErrorView)
    |> render("404.html")
  end
end
