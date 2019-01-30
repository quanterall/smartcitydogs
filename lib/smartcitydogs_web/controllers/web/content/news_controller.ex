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

  def new(conn, _) do
    changeset = News.changeset(%News{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    news = News.get(id)
    changeset = News.changeset(news)
    render(conn, "edit.html", changeset: changeset, news: news)
  end

  def create(conn, %{"news" => params, "files" => file}) do
    image_url = News.store_image(file)

    {:ok, news} =
      params
      |> Map.put("image_url", image_url)
      |> News.create()

    redirect(conn, to: Routes.news_path(conn, :show, news.id))
  end

  def update(conn, %{"news" => params, "id" => id}) do
    News.get(id)
    |> News.update(params)

    redirect(conn, to: Routes.news_path(conn, :show, id))
  end
end
