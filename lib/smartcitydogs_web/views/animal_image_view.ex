defmodule SmartCityDogsWeb.AnimalImageView do
  use SmartCityDogsWeb, :view
  alias SmartCityDogsWeb.AnimalImageView

  def render("index.json", %{animal_images: animal_images}) do
    %{data: render_many(animal_images, AnimalImageView, "animal_image.json")}
  end

  def render("show.json", %{animal_image: animal_image}) do
    %{data: render_one(animal_image, AnimalImageView, "animal_image.json")}
  end

  def render("animal_image.json", %{animal_image: animal_image}) do
    %{id: animal_image.id, url: animal_image.url, deleted_at: animal_image.deleted_at}
  end
end
