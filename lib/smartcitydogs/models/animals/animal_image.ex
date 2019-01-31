defmodule Smartcitydogs.AnimalImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animal_images" do
    field(:url, :string)
    belongs_to(:animal, Smartcitydogs.Animal)
    timestamps()
  end

  @doc false
  def changeset(animal_images, attrs) do
    animal_images
    |> cast(attrs, [:url, :animal_id])
    |> validate_required([:url, :animal_id])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def get(id) do
    Repo.get(__MODULE__, id)
  end

  def delete(image) do
    image
    |> Repo.delete()
  end

  def store_image(upload) do
    extension = Path.extname(upload.filename)
    filename = to_string(:erlang.unique_integer()) <> extension

    File.cp(
      upload.path,
      File.cwd!() <> "/priv/static/images/animals/#{filename}"
    )

    "images/animals/#{filename}"
  end
end
