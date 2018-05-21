defmodule Smartcitydogs.Animals do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animals" do
    field(:address, :string)
    field(:adopted_at, :naive_datetime)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:registered_at, :naive_datetime)
    field(:sex, :string)
    field(:animal_status_id, :id)

    timestamps()
  end

  @doc false
  def changeset(animals, attrs) do
    animals
    |> cast(attrs, [:sex, :chip_number, :address, :deleted_at, :registered_at, :adopted_at])
    |> validate_required([:sex, :chip_number, :address, :deleted_at, :registered_at, :adopted_at])
  end
end
