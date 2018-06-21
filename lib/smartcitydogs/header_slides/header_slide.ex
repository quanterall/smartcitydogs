defmodule SmartCityDogs.HeaderSlides.HeaderSlide do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "header_slides" do
    field(:deleted_at, :naive_datetime)
    field(:image_url, :string)
    field(:text, :string)

    timestamps()
  end

  @doc false
  def changeset(header_slide, attrs) do
    header_slide
    |> cast(attrs, [:image_url, :text, :deleted_at])
    |> validate_required([:image_url, :text])
  end
end
