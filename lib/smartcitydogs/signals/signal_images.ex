defmodule Smartcitydogs.SignalsImages do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.SignalsImages
  alias Smartcitydogs.SignalsImages
  alias Smartcitydogs.Repo

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
      :url,
      :signals_id
    ])
  end

  def insert_images(signal, images) do
    for n <- images do
      extension = Path.extname(n.filename)

      File.cp(
        n.path,
        "../smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{extension}"
      )

      signal_image_params = %{
        "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
        "signals_id" => "#{signal.id}"
      }

      %SignalsImages{}
      |> SignalsImages.changeset(signal_image_params)
      |> Repo.insert()
    end
  end
end
