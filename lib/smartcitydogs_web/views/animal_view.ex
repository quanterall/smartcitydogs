defmodule SmartcitydogsWeb.AnimalView do
  use SmartcitydogsWeb, :view

  def get_image_animals_id(animals_id) do
    list = Smartcitydogs.DataAnimals.get_animal_image_animals_id(animals_id)
    
    if List.first(list) == nil do
      "images/2.jpg"
    else
      List.first(list).url
    end

  end
end
