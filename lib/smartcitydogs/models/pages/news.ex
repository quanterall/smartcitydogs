defmodule Smartcitydogs.News do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.Repo
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "news" do
    field(:content, :string)
    field(:date, :naive_datetime)
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
      :date
    ])
    |> validate_required([
      :image_url,
      :title,
      :content,
      :date,
      :short_content
    ])
    |> validate_length(:title, min: 5)
    |> validate_length(:content, min: 15)
    |> validate_length(:short_content, min: 5)
  end

  def paginate_preloaded(params) do
    from(n in __MODULE__)
    |> Repo.paginate(Map.put(params, :page_size, 8))
  end

  def get_all() do
    Repo.all(__MODULE__)
  end

  def get(id) do
    Repo.get(__MODULE__, id)
  end
end
