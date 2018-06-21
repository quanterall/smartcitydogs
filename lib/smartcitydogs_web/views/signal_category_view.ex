defmodule SmartCityDogsWeb.SignalCategoryView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.SignalCategoryView

  def render("index.json", %{signals_categories: signals_categories}) do
    %{data: render_many(signals_categories, SignalCategoryView, "signal_category.json")}
  end

  def render("show.json", %{signal_category: signal_category}) do
    %{data: render_one(signal_category, SignalCategoryView, "signal_category.json")}
  end

  def render("signal_category.json", %{signal_category: signal_category}) do
    %{id: signal_category.id, name: signal_category.name, deleted_at: signal_category.deleted_at}
  end
end
