defmodule SmartcitydogsWeb.SignalImageControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalImageControllerAPIView

  def render("index.json", %{signals_images: signals_images}) do
    %{data: render_many(signals_images, SignalImageControllerAPIView, "signal_image.json")}
  end

  def render("show.json", %{signal_image: signal_image}) do
    %{data: render_one(signal_image, SignalImageControllerAPIView, "signal_image.json")}
  end

  def render("signal_image.json", %{signal_image_controller_api: signal_image}) do
    %{id: signal_image.id, url: signal_image.url, signals_id: signal_image.signals_id}
  end
end
