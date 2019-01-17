defmodule Smartcitydogs.DataAnimal do
  import Ecto.Query, warn: false
  alias Smartcitydogs.Repo

  alias Smartcitydogs.Animal
  alias Smartcitydogs.AnimalImages
  alias Smartcitydogs.AnimalStatus
  alias Smartcitydogs.PerformedProcedures
  alias Smartcitydogs.AnimalStatus
  alias Smartcitydogs.Adopt
  alias Smartcitydogs.ProcedureType

  ## gets the current time in Sofia
  def get_current_time() do
    Calendar.DateTime.now!("Europe/Sofia") |> DateTime.to_naive()
  end

  def get_procedure_id_by_name(name) do
    {name_query, _} = name
    name_query = "%#{name_query}%"
    query = Ecto.Query.from(c in ProcedureType, where: ilike(c.name, ^name_query))
    [procedure] = Repo.all(query)
    procedure |> Map.get(:id)
  end

  def get_procedures(id) do
    query = Ecto.Query.from(c in PerformedProcedures, where: c.animal_id == ^id)
    Repo.all(query)
  end

  def insert_performed_procedure(procedure_list, animal_id) do
    for procedure <- procedure_list do
      if procedure != nil do
        %PerformedProcedures{}
        |> PerformedProcedures.changeset(%{
          animal_id: animal_id,
          procedure_type_id: procedure
        })
        |> Repo.insert()
      end
    end
  end

  def get_animals_by_status(id) do
    struct = from(p in Animal, where: p.animal_status_id == ^id)
    all_adopted = Repo.all(struct) |> Repo.preload(:animal_status)
    Smartcitydogs.Repo.paginate(all_adopted, page: 1, page_size: 9)
  end

  def get_animal_status(id) do
    Repo.get!(AnimalStatus, id)
  end

  def get_animal(id) do
    Repo.get!(Animal, id) |> Repo.preload(:animal_status)
  end

  def get_adopted_animals() do
    query = Ecto.Query.from(c in Animal, where: c.animal_status_id == 2)
    Repo.all(query)
  end

  def get_shelter_animals() do
    query = Ecto.Query.from(c in Animal, where: c.animal_status_id == 3)
    Repo.all(query)
  end

  def get_animal_image(id) do
    Repo.get!(AnimalImages, id)
  end

  def get_animal_image_animal_id(animal_id) do
    query = Ecto.Query.from(c in AnimalImages, where: c.animal_id == ^animal_id)
    Repo.all(query)
  end

  def sort_animals_by_id() do
    query = Ecto.Query.from(c in Animal, order_by: [c.id])
    Repo.all(query) |> Repo.preload(:animal_status) |> Repo.preload(:animal_images)
  end

  def get_animal_by_chip(chip_number) do
    chip_number = "%#{chip_number}%"
    query = Ecto.Query.from(c in Animal, where: ilike(c.chip_number, ^chip_number))
    Repo.all(query) |> Repo.preload(:animal_status)
  end

  def get_performed_procedure(id) do
    Repo.get!(PerformedProcedures, id)
  end

  def list_animal_statuses do
    Repo.all(AnimalStatus)
  end

  def list_animals do
    Repo.all(Animal) |> Repo.preload(:animal_status)
  end

  def list_animal_images do
    Repo.all(AnimalImages) |> Repo.preload(:animals)
  end

  ## Adds image to existing animal, takes image url and animal id
  def add_animal_image(args \\ %{}) do
    get_animal(args.animal_id)
    |> Ecto.build_assoc(:animal_images, %{url: args.url})
    |> Repo.insert()
  end

  ## Adds image to existing animal, takes image id and animal id
  def add_animal_image_by_id(animal_id, image_id) do
    img = get_animal_image(image_id)
    Ecto.build_assoc(get_animal(animal_id), :animal_images, %{url: img.url})
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
    %Animal{}
    |> Animal.changeset(args)
    |> Repo.insert()
  end

  def create_animal_status(args) do
    %AnimalStatus{}
    |> AnimalStatus.changeset(args)
    |> Repo.insert()
  end

  def update_animal(%Animal{} = animal, args) do
    animal
    |> Animal.changeset(args)
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

  def delete_animal(%Animal{} = animal) do
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

  def change_animal(%Animal{} = animal) do
    Animal.changeset(animal, %{})
  end

  def change_animal_status(%AnimalStatus{} = animal_status) do
    AnimalStatus.changeset(animal_status, %{})
  end

  def change_animal_image(%AnimalImages{} = animal_image) do
    AnimalImages.changeset(animal_image, %{})
  end

  ################ ADOPT INSERT #####################

  def insert_adopt(user_id, animal_id) do
    %Adopt{}
    |> Adopt.changeset(%{user_id: user_id, animal_id: animal_id})
    |> Repo.insert!()
  end

  def check_adopt(user_id, animal_id) do
    query_user = Ecto.Query.from(c in Adopt, where: c.user_id == ^user_id)
    list = Repo.all(query_user)
    check_list(list, animal_id)
  end

  def check_list([], _) do
    false
  end

  def check_list([head | tail], animal_id) do
    if head == [] do
      false
    else
      if head.animal_id == animal_id do
        true
      else
        check_list(tail, animal_id)
      end
    end
  end
end
