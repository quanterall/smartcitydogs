defmodule Smartcitydogs.Rescues do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "rescues" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    belongs_to(:animal, Smartcitydogs.Animals)

    timestamps()
  end

  @doc false
  def changeset(rescues, attrs) do
    rescues
    |> cast(attrs, [:name, :deleted_at, :animal_id])
    |> validate_required([:name])
  end
end
