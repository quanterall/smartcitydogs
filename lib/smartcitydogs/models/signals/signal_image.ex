defmodule Smartcitydogs.SignalImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: true]

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

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def bulk_create(images, %{id: signal_id}) do
    for upload <- images do
      extension = Path.extname(upload.filename)
      filename = to_string(:erlang.unique_integer()) <> extension

      File.cp(
        upload.path,
        File.cwd!() <> "/priv/static/images/#{filename}"
      )

      create(%{
        "url" => "images/#{filename}",
        "signal_id" => "#{signal_id}"
      })
    end
  end
end
