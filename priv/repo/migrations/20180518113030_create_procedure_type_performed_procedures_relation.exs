defmodule Smartcitydogs.Repo.Migrations.CreateProcedureTypePerformedProceduresRelation do
  use Ecto.Migration

  def change do
    alter table(:performed_procedures) do
      add :procedure_type_id, references(:procedure_type)
    end
  end
end
