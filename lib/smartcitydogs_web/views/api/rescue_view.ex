defmodule SmartcitydogsWeb.RescueControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.RescueControllerAPIView

  def render("index.json", %{rescues: rescues}) do
    %{data: render_many(rescues, RescueControllerAPIView, "rescue.json")}
  end

  def render("show.json", %{rescue: rescues}) do
    %{data: render_one(rescues, RescueControllerAPIView, "rescue.json")}
  end

  def render("rescue.json", %{rescue_controller_api: rescues}) do
    %{id: rescues.id, name: rescues.name, deleted_at: rescues.deleted_at}
  end
end
