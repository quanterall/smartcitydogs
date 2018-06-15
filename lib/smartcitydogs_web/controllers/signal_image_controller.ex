defmodule SmartCityDogsWeb.SignalImageController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.SignalImages
  alias SmartCityDogs.SignalImages.SignalImage

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    signal_images = SignalImages.list_signal_images()
    render(conn, "index.json", signal_images: signal_images)
  end

  def create(conn, %{"signal_image" => signal_image_params}) do
    with {:ok, %SignalImage{} = signal_image} <- SignalImages.create_signal_image(signal_image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_image_path(conn, :show, signal_image))
      |> render("show.json", signal_image: signal_image)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_image = SignalImages.get_signal_image!(id)
    render(conn, "show.json", signal_image: signal_image)
  end

  def update(conn, %{"id" => id, "signal_image" => signal_image_params}) do
    signal_image = SignalImages.get_signal_image!(id)

    with {:ok, %SignalImage{} = signal_image} <- SignalImages.update_signal_image(signal_image, signal_image_params) do
      render(conn, "show.json", signal_image: signal_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    signal_image = SignalImages.get_signal_image!(id)
    with {:ok, %SignalImage{}} <- SignalImages.delete_signal_image(signal_image) do
      send_resp(conn, :no_content, "")
    end
  end
end
