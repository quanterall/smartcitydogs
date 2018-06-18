defmodule SmartCityDogsWeb.HeaderSlideController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.HeaderSlides
  alias SmartCityDogs.HeaderSlides.HeaderSlide

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    header_slides = HeaderSlides.list_header_slides()
    render(conn, "index.json", header_slides: header_slides)
  end

  def create(conn, %{"header_slide" => header_slide_params}) do
    with {:ok, %HeaderSlide{} = header_slide} <- HeaderSlides.create_header_slide(header_slide_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", header_slide_path(conn, :show, header_slide))
      |> render("show.json", header_slide: header_slide)
    end
  end

  def show(conn, %{"id" => id}) do
    header_slide = HeaderSlides.get_header_slide!(id)
    render(conn, "show.json", header_slide: header_slide)
  end

  def update(conn, %{"id" => id, "header_slide" => header_slide_params}) do
    header_slide = HeaderSlides.get_header_slide!(id)

    with {:ok, %HeaderSlide{} = header_slide} <- HeaderSlides.update_header_slide(header_slide, header_slide_params) do
      render(conn, "show.json", header_slide: header_slide)
    end
  end

  def delete(conn, %{"id" => id}) do
    header_slide = HeaderSlides.get_header_slide!(id)
    with {:ok, %HeaderSlide{}} <- HeaderSlides.delete_header_slide(header_slide) do
      send_resp(conn, :no_content, "")
    end
  end
end
