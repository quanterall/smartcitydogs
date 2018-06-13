defmodule SmartcitydogsWeb.ForTheProjectController do
  use SmartcitydogsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
