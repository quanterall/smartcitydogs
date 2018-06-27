defmodule SmartcitydogsWeb.AnimalStatusControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.AnimalStatusControllerAPIView

  def render("index.json", %{animal_statuses: animal_statuses}) do
    %{data: render_many(animal_statuses, AnimalStatusControllerAPIView, "animal_status.json")}
  end

  def render("show.json", %{animal_status: animal_status}) do
    %{data: render_one(animal_status, AnimalStatusControllerAPIView, "animal_status.json")}
  end

  def render("animal_status.json", %{animal_status_controller_api: animal_status}) do
    %{id: animal_status.id, name: animal_status.name, deleted_at: animal_status.deleted_at}
  end
end
