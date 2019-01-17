defmodule SmartcitydogsWeb.HeaderSlideControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.HeaderSlide
  alias Smartcitydogs.DataPage

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    header_slides = DataPage.list_header_slides()
    render(conn, "index.json", header_slides: header_slides)
  end

  def create(conn, %{"header_slide" => header_slide_params}) do
    with {:ok, %HeaderSlide{} = header_slide} <-
           DataPage.create_header_slide(header_slide_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", header_slide_controller_api_path(conn, :show, header_slide))
      |> render("show.json", header_slide: header_slide)
    end
  end

  def show(conn, %{"id" => id}) do
    header_slide = DataPage.get_header_slides(id)
    render(conn, "show.json", header_slide: header_slide)
  end

  def update(conn, %{"id" => id, "header_slide" => header_slide_params}) do
    header_slide = DataPage.get_header_slides(id)

    with {:ok, %HeaderSlide{} = header_slide} <-
           DataPage.update_header_slide(header_slide, header_slide_params) do
      render(conn, "show.json", header_slide: header_slide)
    end
  end

  def delete(conn, %{"id" => id}) do
    header_slide = DataPage.get_header_slides(id)

    with {:ok, %HeaderSlide{}} <- DataPage.delete_header_slide(header_slide) do
      send_resp(conn, :no_content, "")
    end
  end
end
