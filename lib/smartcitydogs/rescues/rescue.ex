defmodule SmartCityDogs.Rescues.Rescue do
  use Ecto.Schema
  import Ecto.Changeset

<<<<<<< HEAD
=======
  @timestamps_opts [type: :naive_datetime, usec: false]

>>>>>>> bc631faaf8e88bed50caf154fb13d5f2412bfe89
  schema "rescues" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    belongs_to(:animal, SmartCityDogs.Animals.Animal)
    timestamps()
  end

  @doc false
  def changeset(rescues, attrs) do
    rescues
    |> cast(attrs, [:name, :deleted_at, :animal_id])
    |> validate_required([:name])
  end
end
