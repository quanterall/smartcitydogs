defmodule Smartcitydogs.SignalsTypes do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signals_types" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signals_types, attrs) do
    signals_types
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
