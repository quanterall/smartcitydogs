defmodule Smartcitydogs.News do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.Repo
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "news" do
    field(:content, :string)
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
      :short_content
    ])
    |> validate_required([
      :image_url,
      :title,
      :content,
      :short_content
    ])
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

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def update(news, params) do
    news
    |> changeset(params)
    |> Repo.update()
  end

  def store_image(upload) do
    extension = Path.extname(upload.filename)
    filename = to_string(:erlang.unique_integer()) <> extension

    File.cp(
      upload.path,
      File.cwd!() <> "/priv/static/images/news/#{filename}"
    )

    "images/news/#{filename}"
  end
end
