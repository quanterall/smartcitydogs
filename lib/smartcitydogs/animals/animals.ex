defmodule SmartCityDogs.Animals do
  import Ecto.Query, warn: false
  alias SmartCityDogs.Repo

  alias SmartCityDogs.Animals.Animal

  ## gets the current time in Sofia
  def get_current_time() do
    Calendar.DateTime.now!("Europe/Sofia") |> DateTime.to_naive()
  end

  def list_animals do
    Repo.all(Animal)
  end

  def get_animal!(id), do: Repo.get!(Animal, id)

  def get_animal_by_chip(chip_number) do
    query = Ecto.Query.from(c in Animal, where: c.chip_number == ^chip_number)
    Repo.all(query)
  end

  def create_animal(attrs \\ %{}) do
    %Animal{}
    |> Animal.changeset(attrs)
    |> Repo.insert()
  end

  def register_animal(id) do
    get_animal!(id) |> Map.put(:registered_at, get_current_time())
  end

  def update_animal(%Animal{} = animal, attrs) do
    animal
    |> Animal.changeset(attrs)
    |> Repo.update()
  end

  def delete_animal(%Animal{} = animal) do
    Repo.delete(animal)
  end

  def change_animal(%Animal{} = animal) do
    Animal.changeset(animal, %{})
  end
end
