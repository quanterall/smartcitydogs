defmodule Smartcitydogs.TXHashAnimals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{DataAnimals, Animals, AnimalImages, Repo}

  @required_fields [:tx_hash]
  @fields [:animals_id] ++ @required_fields

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "tx_hash_animals" do
    field(:tx_hash, :string)
    belongs_to(:animals, Smartcitydogs.Animals)

    timestamps()
  end

  @doc false
  def changeset(txHashAnimals, attrs \\ %{}) do
    txHashAnimals
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
