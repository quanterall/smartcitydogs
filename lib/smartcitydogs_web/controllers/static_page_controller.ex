defmodule SmartCityDogsWeb.StaticPageController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.StaticPages
  alias SmartCityDogs.StaticPages.StaticPage

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    static_pages = StaticPages.list_static_pages()
    render(conn, "index.json", static_pages: static_pages)
  end

  def create(conn, %{"static_page" => static_page_params}) do
    with {:ok, %StaticPage{} = static_page} <- StaticPages.create_static_page(static_page_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", static_page_path(conn, :show, static_page))
      |> render("show.json", static_page: static_page)
    end
  end

  def show(conn, %{"id" => id}) do
    static_page = StaticPages.get_static_page!(id)
    render(conn, "show.json", static_page: static_page)
  end

  def update(conn, %{"id" => id, "static_page" => static_page_params}) do
    static_page = StaticPages.get_static_page!(id)

    with {:ok, %StaticPage{} = static_page} <-
           StaticPages.update_static_page(static_page, static_page_params) do
      render(conn, "show.json", static_page: static_page)
    end
  end

  def delete(conn, %{"id" => id}) do
    static_page = StaticPages.get_static_page!(id)

    with {:ok, %StaticPage{}} <- StaticPages.delete_static_page(static_page) do
      send_resp(conn, :no_content, "")
    end
  end
end
