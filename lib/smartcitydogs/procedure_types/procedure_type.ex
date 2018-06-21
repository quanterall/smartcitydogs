defmodule SmartCityDogs.ProcedureTypes.ProcedureType do
  use Ecto.Schema
  import Ecto.Changeset

<<<<<<< HEAD
=======
  @timestamps_opts [type: :naive_datetime, usec: false]

>>>>>>> bc631faaf8e88bed50caf154fb13d5f2412bfe89
  schema "procedure_types" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:performed_procedure, SmartCityDogs.PerformedProcedures.PerformedProcedure)
    timestamps()
  end

  @doc false
  def changeset(procedure_type, attrs) do
    procedure_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
