defmodule Smartcitydogs.AnimalStatus do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animal_status" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many :animals, Smartcitydogs.Animals
    
    timestamps()
  end

  @doc false
  def changeset(animal_status, attrs) do
    animal_status
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
