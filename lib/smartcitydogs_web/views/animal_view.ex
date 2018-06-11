defmodule SmartcitydogsWeb.AnimalView do
  use SmartcitydogsWeb, :view

  def get_image_animals_id(animals_id) do
    list = Smartcitydogs.DataAnimals.get_animal_image_animals_id(animals_id)

    if list != [] do
      [head | tail] = list
      IO.inspect(head.url)
      head.url
      # static_path(@conn, head.url)
    end
  end
end
