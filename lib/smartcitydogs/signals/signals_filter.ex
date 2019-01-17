defmodule Smartcitydogs.SignalFilter do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  embedded_schema do
    field(:signal_category_id, {:array, :string})
    field(:signal_typ_id, {:array, :string})
  end

  @doc false
  def changeset(filter, attrs) do
    filter
    |> cast(attrs, [:signal_category_id, :signal_type_id])
  end
end
