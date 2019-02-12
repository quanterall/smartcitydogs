defmodule SmartcitydogsWeb.Api.SignalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Signal
  alias Smartcitydogs.SignalImage
  alias Smartcitydogs.Guardian

  def index(conn, _params) do
    signals =
      Signal.get_all_preloaded()
      |> SmartcitydogsWeb.Encoder.struct_to_map()

    json(conn, signals)
  end

  def show(conn, %{"id" => id}) do
    case Signal.get_preloaded(id) do
      nil ->
        wrong_signal_id(conn, id)

      signal ->
        {:ok, signal} = Signal.update(signal, %{"view_count" => signal.view_count + 1})

        json(conn, SmartcitydogsWeb.Encoder.struct_to_map(signal))
    end
  end

  def create(conn, %{"signal" => signal_params} = params) do
    %{id: id} = Guardian.Plug.current_resource(conn)

    {:ok, signal} =
      signal_params
      |> Map.put("user_id", id)
      |> Signal.create()

    images = Map.get(params, "images", [])
    IO.inspect(params)
    SignalImage.bulk_create(images, signal)

    redirect(conn, to: Routes.api_signal_path(conn, :show, signal))
  end

  def update(conn, %{"id" => signal_id, "signal" => signal_params}) do
    case Signal.get(signal_id) do
      nil ->
        wrong_signal_id(conn, signal_id)

      signal ->
        Signal.update(signal, Map.delete(signal_params, "user_id"))
        redirect(conn, to: Routes.api_signal_path(conn, :show, signal))
    end
  end

  def wrong_signal_id(conn, id) do
    json(conn, %{error: "There is no signal with id: " <> id})
  end
end
