defmodule SmartCityDogs.AnimalImages do
  @moduledoc """
  The AnimalImages context.
  """

  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.AnimalImages.AnimalImage




  def list_animal_images do
    Repo.all(AnimalImage)
  end


  def get_animal_image!(id), do: Repo.get!(AnimalImage, id)


  def create_animal_image(attrs \\ %{}) do
    %AnimalImage{}
    |> AnimalImage.changeset(attrs)
    |> Repo.insert()
  end


  def update_animal_image(%AnimalImage{} = animal_image, attrs) do
    animal_image
    |> AnimalImage.changeset(attrs)
    |> Repo.update()
  end


  def delete_animal_image(%AnimalImage{} = animal_image) do
    Repo.delete(animal_image)
  end


  def change_animal_image(%AnimalImage{} = animal_image) do
    AnimalImage.changeset(animal_image, %{})
  end
end
