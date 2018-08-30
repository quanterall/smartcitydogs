defmodule Smartcitydogs.Signals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "signals" do
    field(:address, :string)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:description, :string)
    field(:support_count, :integer)
    field(:title, :string)
    field(:view_count, :integer)
    field(:address_B, :float)
    field(:address_F, :float)

    has_many(:signals_comments, Smartcitydogs.SignalsComments)
    belongs_to(:signals_categories, Smartcitydogs.SignalsCategories)
    belongs_to(:signals_types, Smartcitydogs.SignalsTypes)
    has_many(:signal_images, Smartcitydogs.SignalImages)
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
      :signals_types_id,
      :users_id,
      :address_B,
      :address_F
    ])
    |> validate_required([
       :title,
       :address,
       :description,
       :signals_categories_id,
       :signals_types_id
    ])
  end








  ## Get all of the ticked checkboxes from the filters, handle redirection to pagination pages.
  def get_ticked_checkboxes(params) do 
    {data_status, data_category, num} = params
  data_status =  case data_status do
      nil -> []
      _ -> data_status
    end
  data_category =  case data_category do
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
        list_signals = Smartcitydogs.Repo.paginate(all_query, page: num, page_size: 8)

          [list_signals, data_category, data_status]
      data_category != [] ->
        all_query = []

        all_query =
          Enum.map(data_category, fn x ->
            struct = from(p in Signals, where: p.signals_categories_id == ^String.to_integer(x))
            all_query ++ Repo.all(struct)
          end)

          all_query = List.flatten(all_query)
        page = Smartcitydogs.Repo.paginate(all_query, page: 1, page_size: 8)
        [page, data_category, data_status]
      true ->
        all_query = DataSignals.list_signals()
        page = Smartcitydogs.Repo.paginate(all_query, page: 1, page_size: 8)
        [page, data_category, data_status]
    end
  end






end
