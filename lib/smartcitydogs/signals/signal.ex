defmodule Smartcitydogs.Signal do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.Signal
  alias Smartcitydogs.Repo
  alias Smartcitydogs.SignalImage

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signals" do
    field(:address, :string)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:description, :string)
    field(:support_count, :integer, default: 0)
    field(:title, :string)
    field(:view_count, :integer, default: 0)
    field(:longitude, :float)
    field(:latitude, :float)

    has_many(:signal_comments, Smartcitydogs.SignalComment)
    belongs_to(:signal_category, Smartcitydogs.SignalCategory)
    belongs_to(:signal_type, Smartcitydogs.SignalType)
    has_many(:signal_images, Smartcitydogs.SignalImage)
    has_many(:signal_likes, Smartcitydogs.SignalLike)
    belongs_to(:user, Smartcitydogs.User)

    timestamps()
  end

  @doc false
  def changeset(signals, attrs) do
    signals
    |> cast(
      attrs,
      [
        :title,
        :view_count,
        :address,
        :support_count,
        :chip_number,
        :description,
        :deleted_at,
        :signal_category_id,
        :signal_type_id,
        :user_id,
        :longitude,
        :latitude
      ]
    )
    |> validate_required([
      :address,
      :description,
      :signal_category_id
    ])
  end

  def get_like_by_user(signal, user) do
    case user do
      nil ->
        []

      _ ->
        signal
        |> Repo.preload(:signal_likes)

        signal.signal_likes
        |> Enum.filter(fn like -> like.user_id == user.id end)
    end
  end

  def get_first_image(signal) do
    signal =
      signal
      |> Repo.preload(:signal_images)

    if signal.signal_images == [] do
      cond do
        signal.signal_category_id == 1 -> "images/stray.jpg"
        signal.signal_category_id == 2 -> "images/escaped.jpg"
        signal.signal_category_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signal_images).url == nil && signal.signal_category_id == 1 ->
          "images/stray.jpg"

        List.first(signal.signal_images).url == nil && signal.signal_category_id == 2 ->
          "images/escaped.jpg"

        List.first(signal.signal_images).url == nil && signal.signal_category_id == 3 ->
          "images/mistreated.jpg"

        true ->
          List.first(signal.signal_images).url
      end
    end
  end

  def add_like(user_id, signal_id) do
    %Smartcitydogs.SignalLike{}
    |> Smartcitydogs.SignalLike.changeset(%{user_id: user_id, signal_id: signal_id})
    |> Repo.insert()
  end

  def remove_like(user_id, signal_id) do
    from(
      l in Smartcitydogs.SignalLike,
      where: l.user_id == ^user_id and l.signal_id == ^signal_id
    )
    |> Repo.delete_all()
  end

  def create_signal(args \\ %{}) do
    %Signal{}
    |> Signal.changeset(args)
    |> Repo.insert()
  end

  def create_signal_images(args \\ %{}) do
    %SignalImage{}
    |> SignalImage.changeset(args)
    |> Repo.insert()
  end
end
