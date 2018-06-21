defmodule SmartCityDogs.Repo.Migrations.CreatePerformedProcedure do
  use Ecto.Migration

  def change do
    create table(:performed_procedure) do
      add(:date, :naive_datetime)
      add(:deleted_at, :naive_datetime)
      add(:animal_id, references("animals"))
      add(:procedure_type_id, references("procedure_types"))
      timestamps()
    end
  end
end
