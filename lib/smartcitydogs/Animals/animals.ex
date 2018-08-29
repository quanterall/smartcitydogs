defmodule Smartcitydogs.Animals do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  alias Smartcitydogs.Repo
  alias SmartcitydogsWeb.AnimalController


  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animals" do
    field(:address, :string)
    field(:address_B, :float)
    field(:address_F, :float)
    field(:description, :string)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:sex, :string)
    has_many(:animals_image, Smartcitydogs.AnimalImages)
    has_many(:performed_procedure, Smartcitydogs.PerformedProcedures)
    has_many(:rescues, Smartcitydogs.Rescues)
    belongs_to(:animals_status, Smartcitydogs.AnimalStatus)
    has_many(:adopt, Smartcitydogs.Adopt)

    timestamps()
  end

  @doc false
  def changeset(animals, attrs \\ %{}) do
    animals
    |> cast(attrs, [
      :address_B,
      :address_F,
      :description,
      :sex,
      :chip_number,
      :address,
      :deleted_at,
      :animals_status_id
    ])
    |> validate_required([:sex, :chip_number, :address])
  end

  

    ## Get all of the ticked checkboxes from the filters, handle redirection to pagination pages.
    def get_ticked_checkboxes(params) do
      {data_status, page_num} = params
      data_status =
        case data_status do
          nil -> []
          _ -> data_status
        end
  
      page_num = String.to_integer(page_num)
      cond do
        data_status != [] ->
          all_query = []
          animals_query =
            Enum.map(data_status, fn x ->
              struct = from(p in Animals, where: p.animals_status_id == ^String.to_integer(x))
  
              (all_query ++ Repo.all(struct))
              |> Repo.preload(:animals_status)
              |> Repo.preload(:animals_image)
            end)
          animals_query = List.flatten(animals_query)
          list_animals = Smartcitydogs.Repo.paginate(animals_query, page: page_num, page_size: 8)
          [list_animals, data_status]

        true ->
          all_animals = DataAnimals.list_animals()
          page = Smartcitydogs.Repo.paginate(all_animals, page: page_num, page_size: 8)
          [page, data_status]
      end
    end
  










end
