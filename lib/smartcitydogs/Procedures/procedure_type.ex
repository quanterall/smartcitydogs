defmodule Smartcitydogs.ProcedureType do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "procedure_type" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    has_many(:performed_procedures, Smartcitydogs.PerformedProcedures)

    timestamps()
  end

  @doc false
  def changeset(procedure_type, attrs) do
    procedure_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name])
  end
end
