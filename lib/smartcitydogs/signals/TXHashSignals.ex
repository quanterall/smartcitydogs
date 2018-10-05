defmodule Smartcitydogs.TXHashSignals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{DataSignals, Signals, Repo}

  @required_fields [:tx_hash]
  @fields [:signals_id] ++ @required_fields

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "tx_hash_signals" do
    field(:tx_hash, :string)
    belongs_to(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(txHashAnimals, attrs \\ %{}) do
    txHashAnimals
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
