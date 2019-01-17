defmodule SmartcitydogsWeb.MySignalControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalControllerAPIView

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
      signal_type_id: signal.signal_type_id,
      signal_category_id: signal.signal_category_id,
      user_id: signal.user_id
    }
  end
end
