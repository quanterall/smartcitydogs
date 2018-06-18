defmodule SmartCityDogsWeb.NewsSchemaController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.News
  alias SmartCityDogs.News.NewsSchema

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    news = News.list_news()
    render(conn, "index.json", news: news)
  end

  def create(conn, %{"news_schema" => news_schema_params}) do
    with {:ok, %NewsSchema{} = news_schema} <- News.create_news_schema(news_schema_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", news_schema_path(conn, :show, news_schema))
      |> render("show.json", news_schema: news_schema)
    end
  end

  def show(conn, %{"id" => id}) do
    news_schema = News.get_news_schema!(id)
    render(conn, "show.json", news_schema: news_schema)
  end

  def update(conn, %{"id" => id, "news_schema" => news_schema_params}) do
    news_schema = News.get_news_schema!(id)

    with {:ok, %NewsSchema{} = news_schema} <- News.update_news_schema(news_schema, news_schema_params) do
      render(conn, "show.json", news_schema: news_schema)
    end
  end

  def delete(conn, %{"id" => id}) do
    news_schema = News.get_news_schema!(id)
    with {:ok, %NewsSchema{}} <- News.delete_news_schema(news_schema) do
      send_resp(conn, :no_content, "")
    end
  end
end
