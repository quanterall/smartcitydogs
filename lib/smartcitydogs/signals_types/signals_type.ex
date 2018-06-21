defmodule SmartCityDogs.SignalsTypes.SignalsType do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "signals_types" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:signals, SmartCityDogs.Signals.Signal)
    timestamps()
  end

  @doc false
  def changeset(signals_type, attrs \\ %{}) do
    signals_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
