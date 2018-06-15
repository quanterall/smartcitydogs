defmodule SmartCityDogsWeb.SignalCategoryController do
  use SmartCityDogsWeb, :controller

  alias SmartCityDogs.SignalsCategories
  alias SmartCityDogs.SignalsCategories.SignalCategory

  action_fallback SmartCityDogsWeb.FallbackController

  def index(conn, _params) do
    signals_categories = SignalsCategories.list_signals_categories()
    render(conn, "index.json", signals_categories: signals_categories)
  end

  def create(conn, %{"signal_category" => signal_category_params}) do
    with {:ok, %SignalCategory{} = signal_category} <- SignalsCategories.create_signal_category(signal_category_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", signal_category_path(conn, :show, signal_category))
      |> render("show.json", signal_category: signal_category)
    end
  end

  def show(conn, %{"id" => id}) do
    signal_category = SignalsCategories.get_signal_category!(id)
    render(conn, "show.json", signal_category: signal_category)
  end

  def update(conn, %{"id" => id, "signal_category" => signal_category_params}) do
    signal_category = SignalsCategories.get_signal_category!(id)

    with {:ok, %SignalCategory{} = signal_category} <- SignalsCategories.update_signal_category(signal_category, signal_category_params) do
      render(conn, "show.json", signal_category: signal_category)
    end
  end

  def delete(conn, %{"id" => id}) do
    signal_category = SignalsCategories.get_signal_category!(id)
    with {:ok, %SignalCategory{}} <- SignalsCategories.delete_signal_category(signal_category) do
      send_resp(conn, :no_content, "")
    end
  end
end
