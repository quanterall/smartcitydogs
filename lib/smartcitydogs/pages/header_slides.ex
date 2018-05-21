defmodule Smartcitydogs.HeaderSlides do
  use Ecto.Schema
  import Ecto.Changeset

  schema "header_slides" do
    field(:deleted_at, :naive_datetime)
    field(:image_url, :string)
    field(:text, :string)

    timestamps()
  end

  @doc false
  def changeset(header_slides, attrs) do
    header_slides
    |> cast(attrs, [:image_url, :text, :deleted_at])
    |> validate_required([:image_url, :text, :deleted_at])
  end
end
