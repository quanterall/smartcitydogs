defmodule SmartcitydogsWeb.NewsController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.News

  def index(conn, params) do
    page = News.paginate_preloaded(params)
    render(conn, "index.html", page: page)
  end

  def show(conn, %{"id" => id}) do
    news = News.get(id)
    render(conn, "show.html", news: news)
  end
end
