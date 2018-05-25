defmodule Smartcitydogs.Animals do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animals" do
    field(:address, :string)
    field(:adopted_at, :naive_datetime)
    field(:chip_number, :string)
    field(:deleted_at, :naive_datetime)
    field(:registered_at, :naive_datetime)
    field(:sex, :string)
<<<<<<< HEAD
    #field(:animal_status_id, :id)
=======

>>>>>>> d5ccc03a6bab469067eae7bc34d0198614303c68
    has_many :animals_image, Smartcitydogs.AnimalImages
    has_many :performed_procedure, Smartcitydogs.PerformedProcedures
    has_many :rescues, Smartcitydogs.Rescues
    belongs_to :animals_status, Smartcitydogs.AnimalStatus

    timestamps()
  end

  @doc false
  def changeset(animals, attrs) do
    animals
    |> cast(attrs, [:sex, :chip_number, :address, :animals_status_id])
    |> validate_required([:sex, :chip_number, :address])
  end
end
