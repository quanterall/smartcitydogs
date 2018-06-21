defmodule SmartCityDogsWeb.RescueView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.RescueView

  def render("index.json", %{rescues: rescues}) do
    %{data: render_many(rescues, RescueView, "rescue.json")}
  end

  def render("show.json", %{rescue: rescues}) do
    %{data: render_one(rescues, RescueView, "rescue.json")}
  end

  def render("rescue.json", %{rescue: rescues}) do
    %{id: rescues.id, name: rescues.name, deleted_at: rescues.deleted_at}
  end
end
