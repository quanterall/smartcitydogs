defmodule Smartcitydogs.Signals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.Repo
  alias Smartcitydogs.SignalsImages

  @required_fields [
      :address,
      :description,
      :signals_categories_id
    ]
  @fields [
        :title,
        :view_count,
        :support_count,
        :chip_number,
        :deleted_at,
        :signals_types_id,
        :users_id,
        :address_B,
        :address_F
      ] ++ @required_fields
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

    has_many(:signals_comments, Smartcitydogs.SignalsComments)
    belongs_to(:signals_categories, Smartcitydogs.SignalsCategories)
    belongs_to(:signals_types, Smartcitydogs.SignalsTypes, defaults: 1)
    has_many(:signals_images, Smartcitydogs.SignalsImages)
    has_many(:signals_likes, Smartcitydogs.SignalsLikes)
    belongs_to(:users, Smartcitydogs.User)

    timestamps()
  end

  @doc false
  def changeset(signals, attrs) do
    signals
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end

  def get_like_by_user(signal, user) do
    case user do
      nil ->
        []

      _ ->
        signal
        |> Repo.preload(:signals_likes)

        signal.signals_likes
        |> Enum.filter(fn like -> like.users_id == user.id end)
    end
  end

  def get_first_image(signal) do
    signal =
      signal
      |> Repo.preload(:signals_images)

    if signal.signals_images == [] do
      cond do
        signal.signals_categories_id == 1 -> "images/stray.jpg"
        signal.signals_categories_id == 2 -> "images/escaped.jpg"
        signal.signals_categories_id == 3 -> "images/mistreated.jpg"
      end
    else
      cond do
        List.first(signal.signals_images).url == nil && signal.signals_categories_id == 1 ->
          "images/stray.jpg"

        List.first(signal.signals_images).url == nil && signal.signals_categories_id == 2 ->
          "images/escaped.jpg"

        List.first(signal.signals_images).url == nil && signal.signals_categories_id == 3 ->
          "images/mistreated.jpg"

        true ->
          List.first(signal.signals_images).url
      end
    end
  end

  def add_like(user_id, signal_id) do
    %Smartcitydogs.SignalsLikes{}
    |> Smartcitydogs.SignalsLikes.changeset(%{users_id: user_id, signals_id: signal_id})
    |> Repo.insert()
  end

  def remove_like(user_id, signal_id) do
    from(
      l in Smartcitydogs.SignalsLikes,
      where: l.users_id == ^user_id and l.signals_id == ^signal_id
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

  def signal_to_string_for_blockchain_tx(id) do
    DataSignals.get_signal(id)
    |> Map.take(@fields)
    |> Poison.encode!()
  end
end
