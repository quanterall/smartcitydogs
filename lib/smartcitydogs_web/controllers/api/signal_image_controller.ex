defmodule SmartcitydogsWeb.SignalImageControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalImage
  alias Smartcitydogs.DataSignal

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signal_images = DataSignal.list_signal_images()
    render(conn, "index.json", signal_images: signal_images)
  end

  def create(conn, %{"signal_image" => signal_image_params}) do
    with {:ok, %SignalImage{} = signal_image} <-
           DataSignal.create_signal_images(signal_image_params) do
      conn
      |> put_status(:created)
      |> render("show.json", signal_image: signal_image)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_image = DataSignal.get_signal_images(id)
    render(conn, "show.json", signal_image: signal_image)
  end

  def update(conn, %{"id" => id, "signal_image" => signal_image_params}) do
    signal_image = DataSignal.get_signal_images(id)

    with {:ok, %SignalImage{} = signal_image} <-
           DataSignal.update_signal_images(signal_image, signal_image_params) do
      render(conn, "show.json", signal_image: signal_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalImage{}} <- DataSignal.delete_signal_images(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
