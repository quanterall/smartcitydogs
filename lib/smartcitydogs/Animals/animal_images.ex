defmodule Smartcitydogs.AnimalImages do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animal_images" do
    field(:deleted_at, :naive_datetime)
    field(:url, :string)
    belongs_to(:animals, Smartcitydogs.Animals)

    timestamps()
  end

  @doc false
  def changeset(animal_images, attrs) do
    animal_images
    |> cast(attrs, [:url, :deleted_at, :animals_id])

    # |> validate_required([:url])
  end
end
