defmodule SmartCityDogsWeb.HeaderSlideView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.HeaderSlideView

  def render("index.json", %{header_slides: header_slides}) do
    %{data: render_many(header_slides, HeaderSlideView, "header_slide.json")}
  end

  def render("show.json", %{header_slide: header_slide}) do
    %{data: render_one(header_slide, HeaderSlideView, "header_slide.json")}
  end

  def render("header_slide.json", %{header_slide: header_slide}) do
    %{id: header_slide.id,
      image_url: header_slide.image_url,
      text: header_slide.text,
      deleted_at: header_slide.deleted_at}
  end
end
