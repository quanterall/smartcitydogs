defmodule Smartcitydogs.SignalTypes do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signal_types" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    field(:prefix, :string)
    has_many(:signals, Smartcitydogs.Signal)

    timestamps()
  end

  @doc false
  def changeset(signal_type, attrs) do
    signal_type
    |> cast(attrs, [:name, :prefix, :deleted_at])
    |> validate_required([:name])
  end
end
