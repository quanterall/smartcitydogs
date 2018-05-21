defmodule Smartcitydogs.AnimalStatus do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animal_status" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(animal_status, attrs) do
    animal_status
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name, :deleted_at])
  end
end
