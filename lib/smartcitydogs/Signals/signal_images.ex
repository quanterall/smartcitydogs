defmodule Smartcitydogs.SignalImages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "signal_images" do
    field(:url, :string)
    has_many(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signal_images, attrs) do
    signal_images
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
