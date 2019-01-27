defmodule Smartcitydogs.Animal do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.Repo
  alias Smartcitydogs.QueryFilter

  @timestamps_opts [type: :utc_datetime, usec: false]
  @preload [
    :animal_images,
    :animal_status
  ]
  schema "animals" do
    field(:address, :string)
    field(:longitude, :float)
    field(:latitude, :float)
    field(:description, :string)
    field(:chip_number, :string)
    field(:sex, :string)
    has_many(:animal_images, Smartcitydogs.AnimalImage, on_delete: :delete_all)
    # has_many(:performed_procedures, Smartcitydogs.PerformedProcedure, on_delete: :delete_all)
    # has_many(:rescues, Smartcitydogs.Rescue, on_delete: :delete_all)
    belongs_to(:animal_status, Smartcitydogs.AnimalStatus)
    # has_many(:adopts, Smartcitydogs.Adopt, on_delete: :delete_all)

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
  end

  def create(args \\ %{}) do
    %__MODULE__{}
    |> changeset(args)
    |> Repo.insert()
  end

  def preload(query) do
    Repo.preload(query, @preload)
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
end
