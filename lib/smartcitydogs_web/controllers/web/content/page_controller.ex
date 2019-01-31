defmodule SmartcitydogsWeb.PageController do
  use SmartcitydogsWeb, :controller

  def about(conn, _) do
    render(conn, "about.html")
  end

  def help(conn, _) do
    render(conn, "help.html")
  end
end
