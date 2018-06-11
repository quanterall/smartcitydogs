defmodule SmartcitydogsWeb.NewsController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Repo
  alias Smartcitydogs.News
  alias Smartcitydogs.DataPages

  def index(conn, _params) do
    news = DataPages.list_news()
    render(conn, "index.html", news: news)
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
      "/home/sonyft/smartcitydog/smartcitydogs/assets/static/images/#{Map.get(upload, :filename)}-profile#{
        extension
      }"
    )

    news_params = Map.put(news_params, "date", DateTime.utc_now())

    news_params =
      Map.put(
        news_params,
        "image_url",
        "images/#{Map.get(upload, :filename)}-profile#{extension}"
      )

    case DataPages.create_news(news_params) do
      {:ok, news} ->
        conn
        |> put_flash(:info, " News is created!")
        |> redirect(to: news_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # def upload_file(id, conn) do
  #     upload = Map.get(conn, :params)
  #     upload = Map.get(upload, "files")
  #     for n <- upload do    
  #         [head] = n
  #         IO.puts "\n N:"
  #         IO.inspect(n)

  #         extension = Path.extname(head.filename)          
  #         #File.cp(head.path, "/home/sonyft/smartcitydog/smartcitydogs/assets/static/images/#{Map.get(animal_params, "chip_number")}-profile#{}#{extension}")
  #         File.cp(head.path, "/home/sonyft/smartcitydog/smartcitydogs/assets/static/images/#{Map.get(head, :filename)}-profile#{extension}")
  #         args = %{"url" => "images/#{Map.get(head, :filename)}-profile#{extension}", "animals_id" => "#{id}"}
  #         DataAnimals.create_animal_image(args)
  #     end
  # end

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
