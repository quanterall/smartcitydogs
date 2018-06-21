defmodule SmartCityDogs.SignalsCategories.SignalCategory do
  use Ecto.Schema
  import Ecto.Changeset

<<<<<<< HEAD
=======
  @timestamps_opts [type: :naive_datetime, usec: false]

>>>>>>> bc631faaf8e88bed50caf154fb13d5f2412bfe89
  schema "signals_categories" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:signals, SmartCityDogs.Signals.Signal)

    timestamps()
  end

  @doc false
  def changeset(signal_category, attrs) do
    signal_category
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
