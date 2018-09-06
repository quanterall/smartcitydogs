defmodule Smartcitydogs.SignalsImages do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signals_images" do
    field(:url, :string)
    belongs_to(:signals, Smartcitydogs.Signals)

    timestamps()
  end

  @doc false
  def changeset(signals_images, attrs) do
    signals_images
    |> cast(attrs, [
      :url,
      :signals_id
    ])
    |> validate_required([
      ##   :url
    ])
  end
end
