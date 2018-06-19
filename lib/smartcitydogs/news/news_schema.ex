defmodule SmartCityDogs.News.NewsSchema do
  use Ecto.Schema
  import Ecto.Changeset


  schema "news" do
    field :content, :string
    field :date, :naive_datetime
    field :deleted_at, :naive_datetime
    field :image_url, :string
    field :keywords, :string
    field :meta, :string
    field :short_content, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(news_schema, attrs) do
    news_schema
    |> cast(attrs, [:image_url, :title, :meta, :keywords, :content, :short_content, :date, :deleted_at])
    |> validate_required([:image_url, :title, :meta, :keywords, :content, :short_content, :date])
  end
end
