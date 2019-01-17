defmodule Smartcitydogs.DataPage do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.News
  alias Smartcitydogs.StaticPage
  alias Smartcitydogs.HeaderSlide

  def get_news(id) do
    Repo.get!(News, id)
  end

  def get_static_pages(id) do
    Repo.get!(StaticPage, id)
  end

  def get_header_slides(id) do
    Repo.get!(HeaderSlide, id)
  end

  def list_news do
    Repo.all(News)
  end

  def list_static_pages do
    Repo.all(StaticPage)
  end

  def list_header_slides do
    Repo.all(HeaderSlide)
  end

  def create_news(args \\ %{}) do
    %News{}
    |> News.changeset(args)
    |> Repo.insert()
  end

  def create_static_page(args \\ %{}) do
    %StaticPage{}
    |> StaticPage.changeset(args)
    |> Repo.insert()
  end

  def create_header_slide(args \\ %{}) do
    %HeaderSlide{}
    |> HeaderSlide.changeset(args)
    |> Repo.insert()
  end

  def update_news(%News{} = news, args) do
    news
    |> News.changeset(args)
    |> Repo.update()
  end

  def update_static_page(%StaticPage{} = static_page, args) do
    static_page
    |> StaticPage.changeset(args)
    |> Repo.update()
  end

  def update_header_slide(%HeaderSlide{} = header_slide, args) do
    header_slide
    |> HeaderSlide.changeset(args)
    |> Repo.update()
  end

  def delete_news_by_id(id) do
    get_news(id) |> Repo.delete()
  end

  def delete_news(%News{} = news) do
    Repo.delete(news)
  end

  def delete_static_page_by_id(id) do
    get_static_pages(id) |> Repo.delete()
  end

  def delete_static_page(%StaticPage{} = static_page) do
    Repo.delete(static_page)
  end

  def delete_header_slide_by_id(id) do
    get_header_slides(id) |> Repo.delete()
  end

  def delete_header_slide(%HeaderSlide{} = header_slide) do
    Repo.delete(header_slide)
  end

  def change_news(%News{} = news) do
    News.changeset(news, %{})
  end

  def change_static_pages(%StaticPage{} = static_pages) do
    StaticPage.changeset(static_pages, %{})
  end

  def change_header_slide(%HeaderSlide{} = header_slide) do
    HeaderSlide.changeset(header_slide, %{})
  end
end
