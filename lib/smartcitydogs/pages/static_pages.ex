defmodule Smartcitydogs.StaticPages do
  use Ecto.Schema
  import Ecto.Changeset

  schema "static_pages" do
    field(:content, :string)
    field(:deleted_at, :naive_datetime)
    field(:keywords, :string)
    field(:meta, :string)
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(static_pages, attrs) do
    static_pages
    |> cast(attrs, [:title, :meta, :keywords, :content, :deleted_at])
    |> validate_required([:title, :meta, :keywords, :content, :deleted_at])
  end
end
