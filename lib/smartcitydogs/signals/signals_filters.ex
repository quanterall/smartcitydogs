defmodule Smartcitydogs.SignalsFilters do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  embedded_schema do
    field(:signals_categories_id, {:array, :string})
    field(:signals_types_id, {:array, :string})
  end

  @doc false
  def changeset(filter, attrs) do
    filter
    |> cast(attrs, [:signals_categories_id, :signals_types_id])
  end
end
