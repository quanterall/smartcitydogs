defmodule Smartcitydogs.News do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "news" do
    field(:content, :string)
    field(:date, :naive_datetime)
    field(:deleted_at, :naive_datetime)
    field(:image_url, :string)
    field(:short_content, :string)
    field(:title, :string)

    timestamps()
  end

  @doc false
  def changeset(news, attrs \\ %{}) do
    news
    |> cast(attrs, [
      :image_url,
      :title,
      :content,
      :short_content,
      :date,
      :deleted_at
    ])
    |> validate_required([
       :image_url,
      :title,
      :content,
      :date
    ])
  end
end
