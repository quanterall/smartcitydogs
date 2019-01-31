defmodule Smartcitydogs.ProcedureType do
  use Ecto.Schema
  import Ecto.Changeset
  alias Smartcitydogs.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "procedure_types" do
    field(:deleted_at, :naive_datetime)
    field(:name, :string)
    field(:prefix, :string)
    has_many(:performed_procedures, Smartcitydogs.PerformedProcedure)

    timestamps()
  end

  def changeset(procedure_type, attrs) do
    procedure_type
    |> cast(attrs, [:name, :prefix, :deleted_at])
    |> validate_required([:name])
  end

  def create(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def get_all() do
    Repo.all(__MODULE__)
  end
end
