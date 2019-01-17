defmodule SmartcitydogsWeb.SignalsTypeControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.SignalsTypeControllerAPIView

  def render("index.json", %{signal_type: signal_type}) do
    %{data: render_many(signal_type, SignalsTypeControllerAPIView, "signals_type.json")}
  end

  def render("show.json", %{signals_type: signals_type}) do
    %{data: render_one(signals_type, SignalsTypeControllerAPIView, "signals_type.json")}
  end

  def render("signals_type.json", %{signals_type_controller_api: signals_type}) do
    %{id: signals_type.id, name: signals_type.name, deleted_at: signals_type.deleted_at}
  end
end
