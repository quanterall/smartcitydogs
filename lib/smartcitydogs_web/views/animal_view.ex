defmodule SmartCityDogsWeb.AnimalView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.AnimalView

  def render("index.json", %{animals: animals}) do
    %{data: render_many(animals, AnimalView, "animal.json")}
  end

  def render("show.json", %{animal: animal}) do
    %{data: render_one(animal, AnimalView, "animal.json")}
  end

  def render("animal.json", %{animal: animal}) do
    %{id: animal.id,
      sex: animal.sex,
      chip_number: animal.chip_number,
      address: animal.address,
      deleted_at: animal.deleted_at,
      registered_at: animal.registered_at,
      adopted_at: animal.adopted_at}
  end
end
