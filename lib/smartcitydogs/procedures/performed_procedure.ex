defmodule Smartcitydogs.PerformedProcedure do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.{PerformedProcedure, Repo}

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "performed_procedures" do
    field(:date, :naive_datetime)
    field(:deleted_at, :naive_datetime)
    belongs_to(:animal, Smartcitydogs.Animal)
    belongs_to(:procedure_type, Smartcitydogs.ProcedureType)

    timestamps()
  end

  @doc false
  def changeset(performed_procedures, attrs) do
    performed_procedures
    |> cast(attrs, [:date, :deleted_at, :animal_id, :procedure_type_id])
    |> validate_required([])
  end

  def create_procedure(params) do
    %PerformedProcedure{}
    |> PerformedProcedure.changeset(params)
    |> Repo.insert()
  end
end
