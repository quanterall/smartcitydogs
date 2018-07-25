defmodule Smartcitydogs.DataAnimals do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.Animals
  alias Smartcitydogs.AnimalImages
  alias Smartcitydogs.AnimalStatus
  alias Smartcitydogs.PerformedProcedures
  alias Smartcitydogs.Rescues
  alias Smartcitydogs.AnimalStatus

  import Plug.Conn

  ## gets the current time in Sofia
  def get_current_time() do
    Calendar.DateTime.now!("Europe/Sofia") |> DateTime.to_naive()
  end

  def get_animal_status(id) do
    Repo.get!(AnimalStatus, id)
  end

  def get_animal(id) do
    Repo.get!(Animals, id) |> Repo.preload(:animals_status)
  end

  def get_adopted_animals() do
    query = Ecto.Query.from(c in Animals, where: c.animals_status_id == 2)
    Repo.all(query)
  end

  def get_shelter_animals() do
    query = Ecto.Query.from(c in Animals, where: c.animals_status_id == 3)
    Repo.all(query)
  end

  def get_animal_image(id) do
    Repo.get!(AnimalImages, id)
  end

  def get_animal_image_animals_id(animals_id) do
    query = Ecto.Query.from(c in AnimalImages, where: c.animals_id == ^animals_id)
    Repo.all(query)
  end

  def sort_animals_by_id() do
    query = Ecto.Query.from(c in Animals, order_by: [c.id])
    Repo.all(query) |> Repo.preload(:animals_status) |> Repo.preload(:animals_image)
  end

  def get_animal_by_chip(chip_number) do
    

    query = Ecto.Query.from(c in Animals, where: c.chip_number == ^chip_number)
    
    Repo.all(query) |> Repo.preload(:animals_status)
  end

  def get_performed_procedure(id) do
    Repo.get!(PerformedProcedures, id)
  end

  def list_animal_statuses do
    Repo.all(AnimalStatus)
  end

  def list_animals do
    # > Repo.preload(:animals_image)
    Repo.all(Animals) |> Repo.preload(:animals_status)
  end

  def list_animal_images do
    Repo.all(AnimalImages) |> Repo.preload(:animals)
  end

  ## Adds image to existing animal, takes image url and animal id
  def add_animal_image(args \\ %{}) do
    get_animal(args.animals_id)
    |> Ecto.build_assoc(:animals_image, %{url: args.url})
    |> Repo.insert()
  end

  ## Adds image to existing animal, takes image id and animal id
  def add_animal_image_by_id(animal_id, image_id) do
    img = get_animal_image(image_id)
    Ecto.build_assoc(get_animal(animal_id), :animals_image, %{url: img.url})
  end

  ## Adds performed procedure to existing animal, takes animal id and procedure id
  def add_performed_procedure(animal_id, proc_id) do
    perf_proc = get_performed_procedure(proc_id)

    Ecto.build_assoc(get_animal(animal_id), :performed_procedure, %{
      date: perf_proc.date,
      procedure_type_id: perf_proc.procedure_type_id
    })
    |> Repo.insert()
  end

  def create_animal(args \\ %{}) do
    # args = Map.put_new(args, :registered_at, get_current_time())

    %Animals{}
    |> Animals.changeset(args)
    |> Repo.insert()
  end

  def create_animal_status(args) do
    %AnimalStatus{}
    |> AnimalStatus.changeset(args)
    |> Repo.insert()
  end

  def create_animal_image(args) do
    %AnimalImages{}
    |> AnimalImages.changeset(args)
    |> Repo.insert()
  end

  def update_animal(%Animals{} = animal, args) do
    animal
    |> Animals.changeset(args)
    |> Repo.update()
  end

  def update_animal_status(%AnimalStatus{} = animal_status, args) do
    animal_status
    |> AnimalStatus.changeset(args)
    |> Repo.update()
  end

  def update_animal_image(%AnimalImages{} = animal_image, args) do
    animal_image
    |> AnimalImages.changeset(args)
    |> Repo.update()
  end

  def delete_animal_by_id(id) do
    get_animal(id) |> Repo.delete()
  end

  def delete_animal(%Animals{} = animal) do
    Repo.delete(animal)
  end

  def delete_animal_image_by_id(id) do
    get_animal_image(id) |> Repo.delete()
  end

  def delete_animal_image(%AnimalImages{} = animal_image) do
    Repo.delete(animal_image)
  end

  def delete_animal_status_by_id(id) do
    get_animal_status(id) |> Repo.delete()
  end

  def delete_animal_status(%AnimalStatus{} = animal_status) do
    Repo.delete(animal_status)
  end

  def change_animal(%Animals{} = animal) do
    Animals.changeset(animal, %{})
  end

  def change_animal_status(%AnimalStatus{} = animal_status) do
    AnimalStatus.changeset(animal_status, %{})
  end

  def change_animal_image(%AnimalImages{} = animal_image) do
    AnimalImages.changeset(animal_image, %{})
  end
end
