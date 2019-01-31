defmodule Smartcitydogs.AnimalStatus do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animal_statuses" do
    field(:name, :string)
    field(:prefix, :string)
    has_many(:animals, Smartcitydogs.Animal)

    timestamps()
  end

  @doc false
  def changeset(animal_status, attrs) do
    animal_status
    |> cast(attrs, [:name, :prefix])
    |> validate_required([:name])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def get_all() do
    __MODULE__
    |> Repo.all()
  end
end
