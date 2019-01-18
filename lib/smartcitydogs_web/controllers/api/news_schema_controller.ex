defmodule SmartcitydogsWeb.NewsSchemaControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.News
  alias Smartcitydogs.DataPage

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    news = DataPage.list_news()
    render(conn, "index.json", news: news)
  end

  def create(conn, %{"news_schema" => news_schema_params}) do
    with {:ok, %News{} = news_schema} <- DataPage.create_news(news_schema_params) do
      conn
      |> put_status(:created)
      |> render("show.json", news_schema: news_schema)
    end
  end

  def show(conn, %{"id" => id}) do
    news_schema = DataPage.get_news(id)
    render(conn, "show.json", news_schema: news_schema)
  end

  def update(conn, %{"id" => id, "news_schema" => news_schema_params}) do
    news_schema = DataPage.get_news(id)

    with {:ok, %News{} = news_schema} <- DataPage.update_news(news_schema, news_schema_params) do
      render(conn, "show.json", news_schema: news_schema)
    end
  end

  def delete(conn, %{"id" => id}) do
    news_schema = DataPage.get_news(id)

    with {:ok, %News{}} <- DataPage.delete_news(news_schema) do
      send_resp(conn, :no_content, "")
    end
  end
end
