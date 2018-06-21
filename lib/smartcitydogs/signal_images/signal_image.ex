defmodule SmartCityDogs.SignalImages.SignalImage do
  use Ecto.Schema
  import Ecto.Changeset

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
