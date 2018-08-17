defmodule SmartcitydogsWeb.AnimalControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.AnimalControllerAPIView

  def render("index.json", %{animals: animals}) do
    %{data: render_many(animals, AnimalControllerAPIView, "animal.json")}
  end

  def render("show.json", %{animal: animal}) do
    %{data: render_one(animal, AnimalControllerAPIView, "animal.json")}
  end

  def render("animal.json", %{animal_controller_api: animal}) do
    %{
      id: animal.id,
      sex: animal.sex,
      chip_number: animal.chip_number,
      address: animal.address,
      deleted_at: animal.deleted_at,
    }
  end
end
