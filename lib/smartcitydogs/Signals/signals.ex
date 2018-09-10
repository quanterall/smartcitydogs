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
    |> cast(attrs, [
      :title,
      :view_count,
      :address,
      :support_count,
      :chip_number,
      :description,
      :deleted_at,
      :signals_categories_id,
      :users_id,
      :address_B,
      :address_F
    ])
    |> validate_required([
      :address,
      :description,
      :signals_categories_id
    ])
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
    signal = signal |> Repo.preload(:signals_images)

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

  ## Get all of the ticked checkboxes from the filters, handle redirection to pagination pages.
  def get_ticked_checkboxes(params) do
    {data_status, data_category, num} = params

    data_status =
      case data_status do
        nil -> []
        _ -> data_status
      end

    data_category =
      case data_category do
        nil -> []
        _ -> data_category
      end

    num = String.to_integer(num)

    cond do
      data_status != [] ->
        all_query = []

        all_query =
          Enum.map(data_status, fn x ->
            struct = from(p in Signals, where: p.signals_types_id == ^String.to_integer(x))
            all_query ++ Repo.all(struct)
          end)

        all_query = List.flatten(all_query)
        list_signals = Smartcitydogs.Repo.paginate(all_query, page: num, page_size: 9)

        [list_signals, data_category, data_status]

      data_category != [] ->
        all_query = []

        all_query =
          Enum.map(data_category, fn x ->
            struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))
            all_query ++ Repo.all(struct)
          end)

        all_query = List.flatten(all_query)
        page = Smartcitydogs.Repo.paginate(all_query, page: 1, page_size: 9)
        [page, data_category, data_status]

      true ->
        all_query = DataSignals.list_signals()
        page = Smartcitydogs.Repo.paginate(all_query, page: 1, page_size: 9)
        [page, data_category, data_status]
    end
  end

  def get_button_signals(user_id) do
    followed_signals = DataSignals.get_signal_like(user_id)
    liked_signals = Enum.map(followed_signals, fn x -> x |> Map.get(:signals_id) end)
    followed_signals = []

    followed_signals =
      for sig <- liked_signals, do: (followed_signals ++ sig) |> DataSignals.get_signal()

    page = Repo.paginate(followed_signals, page: 1, page_size: 9)
    {page}
  end

  def get_button_signals(user_id, page_num) do
    signals = DataSignals.get_all_followed_signals(user_id)
    followed_signals = DataSignals.get_signal_like(user_id)
    liked_signals = Enum.map(followed_signals, fn x -> x |> Map.get(:signals_id) end)
    followed_signals = []

    followed_signals =
      for sig <- liked_signals, do: (followed_signals ++ sig) |> DataSignals.get_signal()

    page = Repo.paginate(followed_signals, page: page_num, page_size: 9)
    {page, signals}
  end
end
