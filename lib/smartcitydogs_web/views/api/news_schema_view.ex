defmodule SmartcitydogsWeb.NewsSchemaControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.NewsSchemaControllerAPIView

  def render("index.json", %{news: news}) do
    %{data: render_many(news, NewsSchemaControllerAPIView, "news_schema.json")}
  end

  def render("show.json", %{news_schema: news_schema}) do
    %{data: render_one(news_schema, NewsSchemaControllerAPIView, "news_schema.json")}
  end

  def render("news_schema.json", %{news_schema_controller_api: news_schema}) do
    %{
      id: news_schema.id,
      image_url: news_schema.image_url,
      title: news_schema.title,
      meta: news_schema.meta,
      keywords: news_schema.keywords,
      content: news_schema.content,
      short_content: news_schema.short_content,
      date: news_schema.date,
      deleted_at: news_schema.deleted_at
    }
  end
end
