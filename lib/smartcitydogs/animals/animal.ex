defmodule SmartCityDogs.Animals.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts([type: :naive_datetime, usec: false])

  schema "animals" do
    field :address, :string
    field :adopted_at, :naive_datetime
    field :chip_number, :string
    field :deleted_at, :naive_datetime
    field :registered_at, :naive_datetime
    field :sex, :string
    belongs_to :animal_status, SmartCityDogs.AnimalStatuses.AnimalStatus
    has_many :animal_image, SmartCityDogs.AnimalImages.AnimalImage
    has_many :rescues, SmartCityDogs.Rescues.Rescue
    has_many :performed_procedures, SmartCityDogs.PerformedProcedures.PerformedProcedure
    timestamps()
  end

  @doc false
  def changeset(animal, attrs) do
    animal
    |> cast(attrs, [:sex, :chip_number, :address, :deleted_at, :registered_at, :adopted_at, :animal_status_id])
    |> validate_required([:sex, :chip_number, :address])
  end
end
