defmodule Smartcitydogs.SignalsTypes do
  use Ecto.Schema
  import Ecto.Changeset


  schema "signals_types" do
    field :deleted_at, :naive_datetime
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(signals_types, attrs) do
    signals_types
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name, :deleted_at])
  end
end
