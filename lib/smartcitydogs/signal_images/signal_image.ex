defmodule SmartCityDogs.SignalImages.SignalImage do
  use Ecto.Schema
  import Ecto.Changeset

<<<<<<< HEAD
=======
  @timestamps_opts [type: :naive_datetime, usec: false]

>>>>>>> bc631faaf8e88bed50caf154fb13d5f2412bfe89
  schema "signal_images" do
    # field :signals_id, :integer
    field(:url, :string)
    belongs_to(:signals, SmartCityDogs.Signals.Signal)

    timestamps()
  end

  @doc false
  def changeset(signal_image, attrs) do
    signal_image
    |> cast(attrs, [:url, :signals_id])
    |> validate_required([:url, :signals_id])
  end
end
