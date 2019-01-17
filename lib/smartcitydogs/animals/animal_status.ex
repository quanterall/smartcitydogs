defmodule Smartcitydogs.AnimalStatus do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animal_statuses" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    field(:prefix, :string)
    has_many(:animals, Smartcitydogs.Animal)

    timestamps()
  end

  @doc false
  def changeset(animal_status, attrs) do
    animal_status
    |> cast(attrs, [:name, :prefix, :deleted_at])
    |> validate_required([:name])
  end
end
