defmodule SmartcitydogsWeb.StaticPageControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.StaticPage
  alias Smartcitydogs.DataPage

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    static_pages = DataPage.list_static_pages()
    render(conn, "index.json", static_pages: static_pages)
  end

  def create(conn, %{"static_page" => static_page_params}) do
    with {:ok, %StaticPage{} = static_page} <- DataPage.create_static_page(static_page_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", static_page_controller_api_path(conn, :show, static_page))
      |> render("show.json", static_page: static_page)
    end
  end

  def show(conn, %{"id" => id}) do
    static_page = DataPage.get_static_pages(id)
    render(conn, "show.json", static_page: static_page)
  end

  def update(conn, %{"id" => id, "static_page" => static_page_params}) do
    static_page = DataPage.get_static_pages(id)

    with {:ok, %StaticPage{} = static_page} <-
           DataPage.update_static_page(static_page, static_page_params) do
      render(conn, "show.json", static_page: static_page)
    end
  end

  def delete(conn, %{"id" => id}) do
    static_page = DataPage.get_static_pages(id)

    with {:ok, %StaticPage{}} <- DataPage.delete_static_page(static_page) do
      send_resp(conn, :no_content, "")
    end
  end
end
