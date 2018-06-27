defmodule SmartcitydogsWeb.AnimalControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Animals
  alias Smartcitydogs.DataAnimals

  action_fallback(SmartCityDogsWeb.FallbackController)

  def index(conn, _params) do
    ##  IO.inspect _params
    chip = _params["chip_number"]

    if chip == "" do
      animals = DataAnimals.list_animals()
      render(conn, "index.json", animals: animals)
    end

    if chip != nil do
      animals = DataAnimals.get_animal_by_chip(chip)
      render(conn, "index.json", animals: animals)
    end

    animals = DataAnimals.list_animals()
    render(conn, "index.json", animals: animals)
  end

  def create(conn, %{"animal" => animal_params}) do
    with {:ok, %Animals{} = animal} <- DataAnimals.create_animal(animal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", animal_path(conn, :show, animal))
      |> render("show.json", animal: animal)
    end
  end

  def show(conn, %{"id" => id}) do
    animal = DataAnimals.get_animal(id)
    render(conn, "show.json", animal: animal)
  end

  def update(conn, %{"id" => id, "animal" => animal_params}) do
    animal = DataAnimals.get_animal(id)

    with {:ok, %Animals{} = animal} <- DataAnimals.update_animal(animal, animal_params) do
      render(conn, "show.json", animal: animal)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal = DataAnimals.get_animal(id)

    with {:ok, %Animals{}} <- DataAnimals.delete_animal(animal) do
      send_resp(conn, :no_content, "")
    end
  end
end
