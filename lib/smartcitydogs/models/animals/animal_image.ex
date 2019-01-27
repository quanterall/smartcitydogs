defmodule Smartcitydogs.AnimalImage do
  use Ecto.Schema
  import Ecto.Changeset
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animal_images" do
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
end
