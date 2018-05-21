defmodule Smartcitydogs.ProcedureType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "procedure_type" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(procedure_type, attrs) do
    procedure_type
    |> cast(attrs, [:name, :deleted_at])
    |> validate_required([:name, :deleted_at])
  end
end
