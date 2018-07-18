defmodule SmartcitydogsWeb.NewsSchemaControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.News
  alias Smartcitydogs.DataPages

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    news = DataPages.list_news()
    render(conn, "index.json", news: news)
  end

  def create(conn, %{"news_schema" => news_schema_params}) do
    with {:ok, %News{} = news_schema} <- DataPages.create_news(news_schema_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", news_schema_controller_api_path(conn, :show, news_schema))
      |> render("show.json", news_schema: news_schema)
    end
  end

  def show(conn, %{"id" => id}) do
    news_schema = DataPages.get_news(id)
    render(conn, "show.json", news_schema: news_schema)
  end

  def update(conn, %{"id" => id, "news_schema" => news_schema_params}) do
    news_schema = DataPages.get_news(id)

    with {:ok, %News{} = news_schema} <- DataPages.update_news(news_schema, news_schema_params) do
      render(conn, "show.json", news_schema: news_schema)
    end
  end

  def delete(conn, %{"id" => id}) do
    news_schema = DataPages.get_news(id)

    with {:ok, %News{}} <- DataPages.delete_news_schema(news_schema) do
      send_resp(conn, :no_content, "")
    end
  end
end
