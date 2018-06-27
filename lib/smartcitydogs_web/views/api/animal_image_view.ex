defmodule SmartcitydogsWeb.AnimalImageControllerAPIView do
  use SmartcitydogsWeb, :view
  alias SmartcitydogsWeb.AnimalImageControllerAPIView

  def render("index.json", %{animal_images: animal_images}) do
    %{data: render_many(animal_images, AnimalImageControllerAPIView, "animal_image.json")}
  end

  def render("show.json", %{animal_image: animal_image}) do
    %{data: render_one(animal_image, AnimalImageControllerAPIView, "animal_image.json")}
  end

  def render("animal_image.json", %{animal_image_controller_api: animal_image}) do
    %{id: animal_image.id, url: animal_image.url, deleted_at: animal_image.deleted_at}
  end
end
