defmodule SmartCityDogs.AnimalStatuses.AnimalStatus do
  use Ecto.Schema
  import Ecto.Changeset


  schema "animal_statuses" do
    field :deleted_at, :naive_datetime
    field :name, :string
    has_many :animal, SmartCityDogs.Animals.Animal
    timestamps()
  end

  @doc false
  def changeset(animal_status, attrs) do
    animal_status
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
