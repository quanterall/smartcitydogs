defmodule SmartcitydogsWeb.SignalCategoryControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalCategory
  alias Smartcitydogs.DataSignal

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signal_category = DataSignal.list_signal_category()
    render(conn, "index.json", signal_category: signal_category)
  end

  def create(conn, %{"signal_category" => signal_category_params}) do
    with {:ok, %SignalCategory{} = signal_category} <-
           DataSignal.create_signal_category(signal_category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        signal_category_controller_api_path(conn, :show, signal_category)
      )
      |> render("show.json", signal_category: signal_category)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_category = DataSignal.get_signal_category(id)
    render(conn, "show.json", signal_category: signal_category)
  end

  def update(conn, %{"id" => id, "signal_category" => signal_category_params}) do
    signal_category = DataSignal.get_signal_category(id)

    with {:ok, %SignalCategory{} = signal_category} <-
           DataSignal.update_signal_category(signal_category, signal_category_params) do
      render(conn, "show.json", signal_category: signal_category)
    end
  end

  def delete(conn, %{"id" => id}) do
    ## signal_category = DataSignal.get_signal_category(id)

    with {:ok, %SignalCategory{}} <- DataSignal.delete_signal_category(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
