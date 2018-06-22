defmodule Smartcitydogs.SignalImages do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signal_images" do
    field(:url, :string)
    belongs_to(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signal_images, attrs) do
    signal_images
    |> cast(attrs, [
      :url,
      :signals_id
    ])
    |> validate_required([
      :url
    ])
  end
end
