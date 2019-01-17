defmodule Smartcitydogs.AnimalsFilters do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  embedded_schema do
    field(:animal_status_id, :string)
  end

  @doc false
  def changeset(filter, attrs) do
    filter
    |> cast(attrs, [:animal_status_id])
  end
end
