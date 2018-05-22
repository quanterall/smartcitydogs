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

  def get_animal_status(id) do
    Repo.get!(AnimalStatus, id)
  end

  def get_animal(id) do
    Repo.get!(Animals,id)
  end

  def create_animal_image(args \\ %{}) do
    get_animal(args.animals_id)
    |> Ecto.build_assoc(:animal_images,%{deleted_at: args.deleted_at, url: args.url})
    |> Repo.insert()
  end

  def create_animal(args) do
    get_animal_status(args.animal_status_id) |> Ecto.build_assoc(:animals,%{address: args.address,
                                                                             adopted_at: args.adopted_at,
                                                                             chip_number: args.chip_number,
                                                                             deleted_at: args.deleted_at,
                                                                             registered_at: args.registered_at,
                                                                             sex: args.sex})
    |> Repo.insert()
  end

  def create_animal_status(args) do
    %AnimalStatus{}
    |> AnimalStatus.changeset(args)
    |> Repo.insert()
  end

end
