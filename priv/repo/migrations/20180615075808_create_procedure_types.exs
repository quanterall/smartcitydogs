defmodule SmartCityDogs.Repo.Migrations.CreateProcedureTypes do
  use Ecto.Migration

  def change do
    create table(:procedure_types) do
      add :name, :text
      add :deleted_at, :naive_datetime

      timestamps()
    end

  end
end
