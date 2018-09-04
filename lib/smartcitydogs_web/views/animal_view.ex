defmodule SmartcitydogsWeb.AnimalView do
  use SmartcitydogsWeb, :view

  ##add more cond cluases if anumas statuses exceed
  def get_image_animals_id(animals_id) do
    animal = Smartcitydogs.DataAnimals.get_animal(animals_id) |> Smartcitydogs.Repo.preload(:animals_image)
   cond do
    animal.animals_image == nil ->
      cond do
        animal.animals_status_id == 1 -> "images/freed.jpg"
        animal.animals_status_id == 2 -> "images/shelter.jpg"
        animal.animals_status_id == 3 -> "images/adopted.jpg"
      end
      animal.animals_image == [] ->
        cond do
          animal.animals_status_id == 1 -> "images/freed.jpg"
          animal.animals_status_id == 2 -> "images/shelter.jpg"
          animal.animals_status_id == 3 -> "images/adopted.jpg"
        end
    List.first(animal.animals_image).url == nil ->
      cond do
        animal.animals_status_id == 1 -> "images/freed.jpg"
        animal.animals_status_id == 2 -> "images/shelter.jpg"
        animal.animals_status_id == 3 -> "images/adopted.jpg"
      end

    true ->
      List.first(animal.animals_image).url
    end
  end
end
