defmodule Smartcitydogs.SignalImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.SignalImage
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signal_images" do
    field(:url, :string)
    belongs_to(:signal, Smartcitydogs.Signal)
    timestamps()
  end

  @doc false
  def changeset(signal_images, attrs) do
    signal_images
    |> cast(attrs, [
      :url,
      :signal_id
    ])
    |> validate_required([
      :url,
      :signal_id
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
        "signal_id" => "#{signal.id}"
      }

      %SignalImage{}
      |> SignalImage.changeset(signal_image_params)
      |> Repo.insert()
    end
  end
end
