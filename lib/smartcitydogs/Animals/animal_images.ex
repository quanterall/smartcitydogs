defmodule Smartcitydogs.AnimalImages do
  use Ecto.Schema
  import Ecto.Changeset


  schema "animal_images" do
    field :deleted_at, :naive_datetime
    field :url, :string
    field :animals_id, :id

    timestamps()
  end

  @doc false
  def changeset(animal_images, attrs) do
    animal_images
    |> cast(attrs, [:url, :deleted_at])
    |> validate_required([:url, :deleted_at])
  end
end
