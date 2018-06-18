defmodule SmartCityDogs.Repo.Migrations.CreatePerformedProcedure do
  use Ecto.Migration

  def change do
    create table(:performed_procedure) do
      add :date, :naive_datetime
      add :deleted_at, :naive_datetime

      timestamps()
    end

  end
end
