defmodule SmartcitydogsWeb.AnimalView do
  use SmartcitydogsWeb, :view
  import Scrivener.HTML
  ## add more cond cluases if anumas statuses exceed
  def get_image_animal_id(animal_id) do
    animal =
      Smartcitydogs.DataAnimal.get_animal(animal_id)
      |> Smartcitydogs.Repo.preload(:animal_images)

    cond do
      animal.animal_images == nil ->
        cond do
          animal.animal_status_id == 1 -> "images/freed.jpg"
          animal.animal_status_id == 2 -> "images/shelter.jpg"
          animal.animal_status_id == 3 -> "images/adopted.jpg"
        end

      animal.animal_images == [] ->
        cond do
          animal.animal_status_id == 1 -> "images/freed.jpg"
          animal.animal_status_id == 2 -> "images/shelter.jpg"
          animal.animal_status_id == 3 -> "images/adopted.jpg"
        end

      List.first(animal.animal_images).url == nil ->
        cond do
          animal.animal_status_id == 1 -> "images/freed.jpg"
          animal.animal_status_id == 2 -> "images/shelter.jpg"
          animal.animal_status_id == 3 -> "images/adopted.jpg"
        end

      true ->
        List.first(animal.animal_images).url
    end
  end
end
