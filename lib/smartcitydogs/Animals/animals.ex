defmodule Smartcitydogs.Animals do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "animals" do
    field(:address, :string)
    field(:adopted_at, :naive_datetime)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:registered_at, :naive_datetime)
    field(:sex, :string)
    has_many(:animals_image, Smartcitydogs.AnimalImages)
    has_many(:performed_procedure, Smartcitydogs.PerformedProcedures)
    has_many(:rescues, Smartcitydogs.Rescues)
    belongs_to(:animals_status, Smartcitydogs.AnimalStatus)

    timestamps()
  end

  @doc false
  def changeset(animals, attrs \\ %{}) do
    animals
    |> cast(attrs, [
      :sex,
      :chip_number,
      :address,
      :deleted_at,
      :registered_at,
      :adopted_at,
      :animals_status_id
    ])
    |> validate_required([:sex, :chip_number, :address])
  end
end
