defmodule SmartCityDogsWeb.StaticPageView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.StaticPageView

  def render("index.json", %{static_pages: static_pages}) do
    %{data: render_many(static_pages, StaticPageView, "static_page.json")}
  end

  def render("show.json", %{static_page: static_page}) do
    %{data: render_one(static_page, StaticPageView, "static_page.json")}
  end

  def render("static_page.json", %{static_page: static_page}) do
    %{id: static_page.id,
      title: static_page.title,
      meta: static_page.meta,
      keywords: static_page.keywords,
      content: static_page.content,
      deleted_at: static_page.deleted_at}
  end
end
