defmodule Smartcitydogs.Animal do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias Smartcitydogs.{Repo, QueryFilter, AnimalImage, AnimalStatus, Adopt}

  @timestamps_opts [type: :utc_datetime, usec: false]
  @preload [
    :animal_images,
    :animal_status,
    {:performed_procedures, :procedure_type}
  ]
  schema "animals" do
    field(:address, :string)
    field(:longitude, :float)
    field(:latitude, :float)
    field(:description, :string)
    field(:chip_number, :string)
    field(:sex, :string)
    field(:adopted_at, :utc_datetime)
    has_many(:animal_images, AnimalImage, on_delete: :delete_all)
    has_many(:performed_procedures, Smartcitydogs.PerformedProcedure, on_delete: :delete_all)
    # has_many(:rescues, Smartcitydogs.Rescue, on_delete: :delete_all)
    belongs_to(:animal_status, AnimalStatus)
    has_many(:adopts, Adopt, on_delete: :delete_all)

    timestamps()
  end

  @doc false
  def changeset(animals, attrs \\ %{}) do
    animals
    |> cast(attrs, [
      :longitude,
      :latitude,
      :description,
      :sex,
      :chip_number,
      :address,
      :animal_status_id
    ])
    |> validate_required([:sex, :chip_number, :address])
    |> validate_inclusion(:sex, ["male", "famele"])
  end

  def create(args \\ %{}) do
    %__MODULE__{}
    |> changeset(args)
    |> Repo.insert()
  end

  def preload(query) do
    Repo.preload(query, @preload)
  end

  def get_all(filters \\ %{}) do
    from(a in __MODULE__)
    |> QueryFilter.filter(filters)
    |> Repo.all()
  end

  def get_all_preloaded() do
    __MODULE__
    |> Repo.all()
    |> preload()
  end

  def paginate_preloaded(params, filters) do
    from(a in __MODULE__, preload: ^@preload)
    |> QueryFilter.filter(filters)
    |> Repo.paginate(Map.put(params, :page_size, 8))
  end

  def get_preloaded(id) do
    case get(id) do
      nil ->
        nil

      animal ->
        animal |> preload()
    end
  end

  def get(id) do
    Repo.get(__MODULE__, id)
  end

  def get_first_image(animal) do
    first = animal |> Map.get(:animal_images, []) |> List.first()

    if first != nil do
      first.url
    else
      "images/stray.jpg"
    end
  end

  defp count() do
    from(p in __MODULE__, select: count(p.id))
  end

  def get_count() do
    count()
    |> Repo.one()
  end

  def delete(animal) do
    animal
    |> Repo.delete()
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def update(animal, params) do
    animal
    |> changeset(params)
    |> Repo.update()
  end
end
