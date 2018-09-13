defmodule Smartcitydogs.Repo.Migrations.PerformedProcedures do
  use Ecto.Migration

  def change do
    create table("performed_procedures") do
      add(:date, :naive_datetime)
      add(:deleted_at, :naive_datetime)
      add(:procedure_type_id, references("procedure_type", on_delete: :delete_all))
      add(:animals_id, references("animals"))
      timestamps()
    end
  end
end
