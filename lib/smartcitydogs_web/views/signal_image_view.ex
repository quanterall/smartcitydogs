defmodule SmartCityDogsWeb.SignalImageView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.SignalImageView

  def render("index.json", %{signal_images: signal_images}) do
    %{data: render_many(signal_images, SignalImageView, "signal_image.json")}
  end

  def render("show.json", %{signal_image: signal_image}) do
    %{data: render_one(signal_image, SignalImageView, "signal_image.json")}
  end

  def render("signal_image.json", %{signal_image: signal_image}) do
    %{id: signal_image.id, url: signal_image.url, signals_id: signal_image.signals_id}
  end
end
