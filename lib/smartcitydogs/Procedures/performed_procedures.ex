defmodule Smartcitydogs.PerformedProcedures do
  use Ecto.Schema
  import Ecto.Changeset

  schema "performed_procedures" do
    field(:date, :naive_datetime)
    #field(:deleted_at, :naive_datetime)
    #field(:animals_id, :id)
    #field(:procedure_type_id, :id)
    belongs_to :animals, Smartcitydogs.Animals
    belongs_to :procedure_type, Smartcitydogs.ProcedureType

    timestamps()
  end

  @doc false
  def changeset(performed_procedures, attrs) do
    performed_procedures
    |> cast(attrs, [:date, :animals_id, :procedure_type_id])
    |> validate_required([:date, :animals_id, :procedure_type_id])
  end
end
