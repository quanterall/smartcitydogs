defmodule Smartcitydogs.Repo.Migrations.CreatePerformedProceduresAnimalsRelation do
  use Ecto.Migration

  def change do
    alter table(:performed_procedures) do
      add :animal_id, references(:animal)
    end
  end
end
