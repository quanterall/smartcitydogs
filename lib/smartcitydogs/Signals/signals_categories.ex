defmodule Smartcitydogs.SignalsCategories do
  use Ecto.Schema
  import Ecto.Changeset

  schema "signals_categories" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signals_categories, attrs) do
    signals_categories
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
