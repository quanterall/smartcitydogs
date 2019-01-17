defmodule Smartcitydogs.AnimalImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.AnimalImage
  alias Smartcitydogs.Repo
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animal_images" do
    field(:deleted_at, :naive_datetime)
    field(:url, :string)
    belongs_to(:animal, Smartcitydogs.Animal)

    timestamps()
  end

  @doc false
  def changeset(animal_images, attrs) do
    animal_images
    |> cast(attrs, [:url, :deleted_at, :animal_id])
    |> validate_required([:url, :animal_id])
  end

  def store_images(animal, images) do
    for n <- images do
      extension = Path.extname(n.filename)

      File.cp(
        n.path,
        "../smartcitydogs/assets/static/images/#{Map.get(n, :filename)}-profile#{extension}"
      )

      animal_image_params = %{
        "url" => "images/#{Map.get(n, :filename)}-profile#{extension}",
        "animal_id" => "#{animal.id}"
      }

      create_animal_image(animal_image_params)
    end
  end

  def create_animal_image(params) do
    %AnimalImage{}
    |> AnimalImage.changeset(params)
    |> Repo.insert()
  end
end
