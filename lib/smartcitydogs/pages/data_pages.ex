defmodule Smartcitydogs.DataPages do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.News
  alias Smartcitydogs.StaticPages
  alias Smartcitydogs.HeaderSlides

  def get_news(id) do
    Repo.get!(News, id)
  end

  def get_static_pages(id) do
    Repo.get!(StaticPages, id)
  end

  def get_header_slides(id) do
    Repo.get!(HeaderSlides, id)
  end

  def list_news do
    Repo.all(News)
  end

  def list_static_pages do
    Repo.all(StaticPages)
  end

  def list_header_slides do
    Repo.all(HeaderSlides)
  end

  def create_news(args \\ %{}) do
    %News{}
    |> News.changeset(args)
    |> Repo.insert()
  end

  def create_static_page(args \\ %{}) do
    %StaticPages{}
    |> StaticPages.changeset(args)
    |> Repo.insert()
  end

  def create_header_slide(args \\ %{}) do
    %HeaderSlides{}
    |> HeaderSlides.changeset(args)
    |> Repo.insert()
  end

  def update_news(%News{} = news, args) do
    news
    |> News.changeset(args)
    |> Repo.update()
  end

  def update_static_page(%StaticPages{} = static_page, args) do
    static_page
    |> StaticPages.changeset(args)
    |> Repo.update()
  end

  def update_header_slide(%HeaderSlides{} = header_slide, args) do
    header_slide
    |> HeaderSlides.changeset(args)
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

  def delete_static_page(%StaticPages{} = static_page) do
    Repo.delete(static_page)
  end

  def delete_header_slide_by_id(id) do
    get_header_slides(id) |> Repo.delete()
  end

  def delete_header_slide(%HeaderSlides{} = header_slide) do
    Repo.delete(header_slide)
  end

  def change_news(%News{} = news) do
    News.changeset(news, %{})
  end

  def change_static_pages(%StaticPages{} = static_pages) do
    StaticPages.changeset(static_pages, %{})
  end

  def change_header_slide(%HeaderSlides{} = header_slide) do
    HeaderSlides.changeset(header_slide, %{})
  end
end
