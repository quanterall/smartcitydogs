defmodule SmartcitydogsWeb.SignalTypeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalTypeControllerAPIView

  def render("index.json", %{signal_type: signal_type}) do
    %{data: render_many(signal_type, SignalTypeControllerAPIView, "signal_type.json")}
  end

  def render("show.json", %{signal_type: signal_type}) do
    %{data: render_one(signal_type, SignalTypeControllerAPIView, "signal_type.json")}
  end

  def render("signal_type.json", %{signal_type_controller_api: signal_type}) do
    %{id: signal_type.id, name: signal_type.name, deleted_at: signal_type.deleted_at}
  end
end
