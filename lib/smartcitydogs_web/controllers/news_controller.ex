defmodule SmartcitydogsWeb.NewsController do
  use SmartcitydogsWeb, :controller

  import Ecto.Query
  alias Smartcitydogs.News
  alias Smartcitydogs.DataPages
  alias Smartcitydogs.Repo
  #alias Smartcitydogs.Markdown

  def index(conn, %{"page" => page_number}) do
    news = DataPages.list_news()
    news2 = Enum.slice(news, -3..-2) ##second and third to last created news
    last_news = Repo.one(from n in News, order_by: [desc: n.id], limit: 1)
    news = Enum.drop(news, -3)
    page = Smartcitydogs.Repo.paginate(news, page: String.to_integer(page_number), page_size: 8)
    render(conn, "index.html", news: page.entries, last_news: last_news, news2: news2, page: page)
  end
  
  def index(conn, %{}) do
    news = DataPages.list_news()
    news2 = 
      cond do
        length(news) == 2 -> Enum.slice(news, -2..-2) ++ []
        length(news) == 1 -> [[],[]]
        length(news) == 0 -> [[],[]]
      end
    last_news = Repo.one(from n in News, order_by: [desc: n.id], limit: 1)
    news = Enum.drop(news, -3)
    page = Smartcitydogs.Repo.paginate(news, page: 1, page_size: 8)
    render(conn, "index.html", news: page.entries, last_news: last_news, news2: news2, page: page)
  end



  def new(conn, _params) do
    changeset = News.changeset(%News{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"news" => news_params}) do
     image_name = String.split(news_params["image_url"], "\\") |> List.last 
     extension = Path.extname(image_name)
    upload = 
    %Plug.Upload{
      content_type: "image/jpeg",
      filename: image_name,
      path: "./smartcitydogs/assets/static/images/#{image_name}-profile#{extension}"
    }
    
    news_params = Map.put(news_params, "date", DateTime.utc_now())
    news_params =
      Map.put(
        news_params,
        "image_url",
        "images/#{Map.get(upload, :filename)}-profile#{extension}"
      )
      news_params =
        if news_params["image_url"] == "images/-profile" do
          Map.put(news_params, "image_url", "")
        end
      case DataPages.create_news(news_params) do
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
