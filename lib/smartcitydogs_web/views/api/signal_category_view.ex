defmodule SmartcitydogsWeb.SignalCategoryControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalCategoryControllerAPIView

  def render("index.json", %{signals_categories: signals_categories}) do
    %{data: render_many(signals_categories, SignalCategoryControllerAPIView, "signal_category.json")}
  end

  def render("show.json", %{signal_category: signal_category}) do
    %{data: render_one(signal_category, SignalCategoryControllerAPIView, "signal_category.json")}
  end

  def render("signal_category.json", %{signal_category_controller_api: signal_category}) do
    %{id: signal_category.id, name: signal_category.name, deleted_at: signal_category.deleted_at}
  end
end
