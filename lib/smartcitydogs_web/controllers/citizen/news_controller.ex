defmodule SmartcitydogsWeb.NewsController do
  use SmartcitydogsWeb, :controller

  import Ecto.Query
  alias Smartcitydogs.News
  alias Smartcitydogs.DataPage
  alias Smartcitydogs.Repo
  # alias Smartcitydogs.Markdown

  def index(conn, params) do
    page =
      News
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(params)

    render(conn, "index.html", news: page.entries, page: page)
  end

  def new(conn, _params) do
    changeset = News.changeset(%News{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"news" => news_params} = params) do
    extension = Path.extname(params["files"].filename)

    File.cp(
      params["files"].path,
      "../smartcitydogs/assets/static/images/#{Map.get(params["files"], :filename)}-profile#{
        extension
      }"
    )

    news_params =
      Map.put(
        news_params,
        "image_url",
        "images/#{Map.get(params["files"], :filename)}-profile#{extension}"
      )

    news_params = Map.put(news_params, "date", DateTime.utc_now())

    case DataPage.create_news(news_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, " News is created!")
        |> redirect(to: news_path(conn, :index))

      {:error, _} ->
        conn
        |> put_status(:not_acceptable)
        |> send_resp(:not_acceptable, "")
    end
  end

  def show(conn, %{"id" => id}) do
    news = DataPage.get_news(id)
    render(conn, "show.html", news: news)
  end

  def edit(conn, %{"id" => id}) do
    news = DataPage.get_news(id)
    changeset = DataPage.change_news(news)
    render(conn, "edit.html", news: news, changeset: changeset)
  end

  def update(conn, %{"id" => id, "news" => news_params} = params) do
    extension = Path.extname(params["files"].filename)

    File.cp(
      params["files"].path,
      "../smartcitydogs/assets/static/images/#{Map.get(params["files"], :filename)}-profile#{
        extension
      }"
    )

    news_params =
      Map.put(
        news_params,
        "image_url",
        "images/#{Map.get(params["files"], :filename)}-profile#{extension}"
      )

    news = DataPage.get_news(id)
    news_params = Map.put(news_params, "date", DateTime.utc_now())

    case DataPage.update_news(news, news_params) do
      {:ok, news} ->
        conn
        |> put_flash(:info, "News is updated successfully.")
        |> redirect(to: news_path(conn, :show, news))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", news: news, changeset: changeset)
    end
  end
end
