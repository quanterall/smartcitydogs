defmodule SmartCityDogs.Rescues.Rescue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rescues" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    belongs_to(:animal, SmartCityDogs.Animals.Animal)
    timestamps()
  end

  @doc false
  def changeset(rescues, attrs) do
    rescues
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
