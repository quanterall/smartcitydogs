defmodule Smartcitydogs.Signals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.Repo
  alias Smartcitydogs.SignalsImages

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signals" do
    field(:address, :string)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:description, :string)
    field(:support_count, :integer, default: 0)
    field(:title, :string)
    field(:view_count, :integer, default: 0)
    field(:address_B, :float)
    field(:address_F, :float)

    has_many(:signal_comments, Smartcitydogs.SignalsComments)
    belongs_to(:signal_category, Smartcitydogs.SignalsCategories)
    belongs_to(:signal_type, Smartcitydogs.SignalsTypes)
    has_many(:signal_images, Smartcitydogs.SignalsImages)
    has_many(:signal_likes, Smartcitydogs.SignalsLikes)
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
        :address_B,
        :address_F
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
      |> Repo.preload(:signals_images)

    if signal.signals_images == [] do
      cond do
        signal.signal_category_id == 1 -> "images/stray.jpg"
        signal.signal_category_id == 2 -> "images/escaped.jpg"
        signal.signal_category_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signals_images).url == nil && signal.signal_category_id == 1 ->
          "images/stray.jpg"

        List.first(signal.signals_images).url == nil && signal.signal_category_id == 2 ->
          "images/escaped.jpg"

        List.first(signal.signals_images).url == nil && signal.signal_category_id == 3 ->
          "images/mistreated.jpg"

        true ->
          List.first(signal.signals_images).url
      end
    end
  end

  def add_like(user_id, signal_id) do
    %Smartcitydogs.SignalsLikes{}
    |> Smartcitydogs.SignalsLikes.changeset(%{user_id: user_id, signal_id: signal_id})
    |> Repo.insert()
  end

  def remove_like(user_id, signal_id) do
    from(
      l in Smartcitydogs.SignalsLikes,
      where: l.user_id == ^user_id and l.signal_id == ^signal_id
    )
    |> Repo.delete_all()
  end

  def create_signal(args \\ %{}) do
    %Signals{}
    |> Signals.changeset(args)
    |> Repo.insert()
  end

  def create_signal_images(args \\ %{}) do
    %SignalsImages{}
    |> SignalsImages.changeset(args)
    |> Repo.insert()
  end
end
