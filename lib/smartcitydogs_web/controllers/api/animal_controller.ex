defmodule SmartcitydogsWeb.AnimalControllerAPI do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Animals
  alias Smartcitydogs.DataAnimals

  action_fallback(SmartCityDogsWeb.FallbackController)

  def send_email(conn,data) do
    int = String.to_integer(data["animal_id"])
    Smartcitydogs.Email.send_email(data)
    DataAnimals.insert_adopt(data["user_id"], data["animal_id"])
    redirect conn, to: "/registered/#{int}"
  end

  def index(conn, params) do
    cond do
      params == %{} || params["chip_number"] == "" ->

        list_animals =
          DataAnimals.list_animals

        render(
          conn,
          "index.json",
          animals: list_animals,
          chip_number: params["chip_number"]
        )
      params != %{} ->
        animals = DataAnimals.get_animal_by_chip(params["chip_number"])

        render(
          conn,
          "index.json",
          animals: animals,
          chip_number: params["chip_number"]
        )
      params["chip_number"] != nil ->
        chip = params["chip_number"]
        animals = DataAnimals.get_animal_by_chip(chip) 
          |> Repo.preload(:animals_status) 
          |> Repo.preload(:animals_image)
        
        render(
          conn,
          "index.json",
          animals: animals,
          chip_number: params["chip_number"]
        )
    end
  end





  def create(conn, %{"animal" => animal_params}) do
   
    map_procedures = %{
      "Кастрирано" => animal_params["Кастрирано"],
      "Обезпаразитено" => animal_params["Обезпаразитено"],
      "Ваксинирано" => animal_params["Ваксинирано"]
    }

    list_procedures = Enum.map(map_procedures, fn(x) -> 
      case x do 
        {_, "true"} -> DataAnimals.get_procedure_id_by_name(x)
        _ -> nil
      end 
    
    end)
    
      case DataAnimals.create_animal(animal_params) do
        {:ok, animal} ->
          # SmartcitydogsWeb.AnimalController.upload_file(animal.id, conn)

          DataAnimals.insert_performed_procedure(list_procedures, animal.id)

          render(conn, "show.json", animal: animal)

        {:error, changeset} ->
          render(conn, "show.json", changeset: changeset)
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
