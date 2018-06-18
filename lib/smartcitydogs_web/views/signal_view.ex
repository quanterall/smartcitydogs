defmodule SmartCityDogsWeb.SignalView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.SignalView

  def render("index.json", %{signals: signals}) do
    %{data: render_many(signals, SignalView, "signal.json")}
  end

  def render("show.json", %{signal: signal}) do
    %{data: render_one(signal, SignalView, "signal.json")}
  end

  def render("signal.json", %{signal: signal}) do
    %{id: signal.id,
      title: signal.title,
      view_count: signal.view_count,
      address: signal.address,
      support_count: signal.support_count,
      chip_number: signal.chip_number,
      description: signal.description,
      deleted_at: signal.deleted_at,
      signals_types_id: signal.signals_types_id,
      signals_categories_id: signal.signals_categories_id,
      users_id: signal.users_id}
  end
end
