defmodule Smartcitydogs.SignalsCategories do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signal_category" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signal_category, attrs) do
    signal_category
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
