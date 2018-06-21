defmodule SmartCityDogs.PerformedProcedures.PerformedProcedure do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime, usec: false]

  schema "performed_procedure" do
    field(:date, :string)
    field(:deleted_at, :naive_datetime)
    belongs_to(:animal, SmartCityDogs.Animals.Animal)
    belongs_to(:procedure_type, SmartCityDogs.ProcedureTypes.ProcedureType)
    timestamps()
  end

  @doc false
  def changeset(performed_procedure, attrs) do
    performed_procedure
    |> cast(attrs, [:date, :deleted_at, :animal_id, :procedure_type_id])
    |> validate_required([:date, :animal_id, :procedure_type_id])
  end
end
