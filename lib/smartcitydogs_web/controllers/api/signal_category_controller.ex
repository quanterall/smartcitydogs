defmodule SmartcitydogsWeb.SignalCategoryControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.SignalsCategories
  alias Smartcitydogs.DataSignals

  action_fallback(SmartcitydogsWeb.FallbackController)

  def index(conn, _params) do
    signals_categories = DataSignals.list_signal_category()
    render(conn, "index.json", signals_categories: signals_categories)
  end

  def create(conn, %{"signal_category" => signal_category_params}) do
    with {:ok, %SignalsCategories{} = signal_category} <-
      DataSignals.create_signal_category(signal_category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_category_controller_api_path(conn, :show, signal_category))
      |> render("show.json", signal_category: signal_category)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_category = DataSignals.get_signal_category(id)
    render(conn, "show.json", signal_category: signal_category)
  end

  def update(conn, %{"id" => id, "signal_category" => signal_category_params}) do
    signal_category = DataSignals.get_signal_category(id)

    with {:ok, %SignalsCategories{} = signal_category} <-
      DataSignals.update_signal_category(signal_category, signal_category_params) do
      render(conn, "show.json", signal_category: signal_category)
    end
  end

  def delete(conn, %{"id" => id}) do
    ##signal_category = DataSignals.get_signal_category(id)

    with {:ok, %SignalsCategories{}} <- DataSignals.delete_signal_category(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
