defmodule Smartcitydogs.Signal do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.{Repo, QueryFilter}

  @timestamps_opts [type: :utc_datetime, usec: true]
  schema "signals" do
    field(:address, :string)
    field(:chip_number, :string)
    field(:description, :string)
    field(:title, :string)
    field(:longitude, :float)
    field(:latitude, :float)
    field(:view_count, :integer, default: 0)

    has_many(:signal_comments, Smartcitydogs.SignalComment)
    belongs_to(:signal_category, Smartcitydogs.SignalCategory)
    belongs_to(:signal_type, Smartcitydogs.SignalType)
    has_many(:signal_images, Smartcitydogs.SignalImage)
    has_many(:signal_likes, Smartcitydogs.SignalLike)
    belongs_to(:user, Smartcitydogs.User)

    timestamps()
  end

  @preload [
    :user,
    :signal_images,
    :signal_comments,
    :signal_likes,
    {:signal_comments, :user},
    :signal_category,
    :signal_type
  ]
  @doc false
  def changeset(signals, attrs) do
    signals
    |> cast(
      attrs,
      [
        :title,
        :view_count,
        :address,
        :chip_number,
        :description,
        :signal_category_id,
        :signal_type_id,
        :user_id,
        :longitude,
        :latitude
      ]
    )
    |> validate_required([
      :description,
      :signal_category_id
    ])
  end

  def preload(query) do
    Repo.preload(query, @preload)
  end

  def get_all_preloaded() do
    __MODULE__
    |> Repo.all()
    |> preload()
  end

  def paginate_preloaded(params, filters) do
    from(s in __MODULE__, preload: ^@preload)
    |> QueryFilter.filter(filters)
    |> Repo.paginate(params)
  end

  def get_preloaded(id) do
    case get(id) do
      nil ->
        nil

      signal ->
        signal |> preload()
    end
  end

  def get(id) do
    Repo.get(__MODULE__, id)
  end

  defp count() do
    from(p in __MODULE__, select: count(p.id))
  end

  def get_count() do
    count()
    |> Repo.one()
  end

  def get_count_by_user_id(user_id) do
    count()
    |> where([s], s.user_id == ^user_id)
    |> Repo.one()
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def update(signal, params) do
    signal
    |> changeset(params)
    |> Repo.update()
  end

  def get_first_image(signal) do
    first = signal |> Repo.preload(:signal_images) |> Map.get(:signal_images, []) |> List.first()

    if first != nil do
      first.url
    else
      cond do
        signal.signal_category_id == 1 -> "images/stray.jpg"
        signal.signal_category_id == 2 -> "images/escaped.jpg"
        signal.signal_category_id == 3 -> "images/mistreated.jpg"
      end
    end
  end
end
