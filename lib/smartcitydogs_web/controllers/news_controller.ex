defmodule SmartcitydogsWeb.NewsController do
  use SmartcitydogsWeb, :controller

  import Ecto.Query
  alias Smartcitydogs.News
  alias Smartcitydogs.DataPages
  alias Smartcitydogs.Repo
  alias Smartcitydogs.Markdown

  def index(conn, _params) do
    news = DataPages.list_news()
    news2 = Enum.slice(news, -3..-2)
    last_news = Repo.one(from x in News, order_by: [desc: x.id], limit: 1)
    news = Enum.drop(news, -3)
    render(conn, "index.html", news: news, last_news: last_news, news2: news2)
  end

  def new(conn, _params) do
    changeset = News.changeset(%News{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"news" => news_params}) do
    upload = Map.get(conn, :params)
    upload = Map.get(upload, "files")

    extension = Path.extname(upload.filename)

    File.cp(
      upload.path,
      "../smartcitydogs/assets/static/images/#{Map.get(upload, :filename)}-profile#{extension}"
    )

    news_params = Map.put(news_params, "date", DateTime.utc_now())

    news_params =
      Map.put(
        news_params,
        "image_url",
        "images/#{Map.get(upload, :filename)}-profile#{extension}"
      )

    {:safe, xxx} =
     news_params["content"]
     |> Markdown.to_html()
     |> Phoenix.HTML.raw() # Convert to {:safe, iodata} tuple

     news_params |> Map.delete("content") |> Map.put("content", xxx)
    case DataPages.create_news(news_params) do
      {:ok, news} ->
        conn
        |> put_flash(:info, " News is created!")
        |> redirect(to: news_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    news = DataPages.get_news(id)
    render(conn, "show.html", news: news)
  end

  def edit(conn, %{"id" => id}) do
    news = DataPages.get_news(id)
    changeset = DataPages.change_news(news)
    render(conn, "edit.html", news: news, changeset: changeset)
  end

  def update(conn, %{"id" => id, "news" => news_params}) do
    news = DataPages.get_news(id)

    news_params = Map.put(news_params, "date", DateTime.utc_now())

    case DataPages.update_news(news, news_params) do
      {:ok, news} ->
        conn
        |> put_flash(:info, "News is updated successfully.")
        |> redirect(to: news_path(conn, :show, news))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", news: news, changeset: changeset)
    end
  end
end
