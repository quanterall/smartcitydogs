defmodule SmartcitydogsWeb.MySignalsControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalControllerAPIView
  alias Smartcitydogs.SignalView

  def render("index.json", %{signals: signals}) do
    %{data: render_many(signals, SignalControllerAPIView, "signals.json")}
  end

  def render("signals.json", %{signal_controller_api: signal}) do
    %{
      id: signal.id,
      title: signal.title,
      view_count: signal.view_count,
      address: signal.address,
      support_count: signal.support_count,
      chip_number: signal.chip_number,
      description: signal.description,
      deleted_at: signal.deleted_at,
      signals_types_id: signal.signals_types_id,
      signals_categories_id: signal.signals_categories_id,
      users_id: signal.users_id
    }
  end
end
