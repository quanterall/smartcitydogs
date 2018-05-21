defmodule Smartcitydogs.Repo.Migrations.CreatePerformedProceduresAnimalsRelation do
  use Ecto.Migration

  def change do
    alter table(:performed_procedures) do
      add(:animals_id, references(:animals))
    end
  end
end
