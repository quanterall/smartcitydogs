defmodule SmartcitydogsWeb.SignalImageControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalsImages
  alias Smartcitydogs.DataSignals

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signals_images = DataSignals.list_signal_images()
    render(conn, "index.json", signals_images: signals_images)
  end

  def create(conn, %{"signal_image" => signal_image_params}) do
    with {:ok, %SignalsImages{} = signal_image} <-
           DataSignals.create_signal_images(signal_image_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_image_controller_api_path(conn, :show, signal_image))
      |> render("show.json", signal_image: signal_image)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_image = DataSignals.get_signal_images(id)
    render(conn, "show.json", signal_image: signal_image)
  end

  def update(conn, %{"id" => id, "signal_image" => signal_image_params}) do
    signal_image = DataSignals.get_signal_images(id)

    with {:ok, %SignalsImages{} = signal_image} <-
           DataSignals.update_signal_images(signal_image, signal_image_params) do
      render(conn, "show.json", signal_image: signal_image)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %SignalsImages{}} <- DataSignals.delete_signal_images(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
