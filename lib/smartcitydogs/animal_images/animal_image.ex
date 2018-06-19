defmodule SmartCityDogs.AnimalImages.AnimalImage do
  use Ecto.Schema
  import Ecto.Changeset


  schema "animal_images" do
    field :deleted_at, :naive_datetime
    field :url, :string
    belongs_to :animal, SmartCityDogs.Animals.Animal 
    timestamps()
  end

  @doc false
  def changeset(animal_image, attrs) do
    animal_image
    |> cast(attrs, [:url, :deleted_at])
    |> validate_required([:url])
  end
end
