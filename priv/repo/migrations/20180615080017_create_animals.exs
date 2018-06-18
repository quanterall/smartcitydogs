defmodule SmartCityDogs.Repo.Migrations.CreateAnimals do
  use Ecto.Migration

  def change do
    create table(:animals) do
      add :sex, :text
      add :chip_number, :text
      add :address, :text
      add :deleted_at, :naive_datetime
      add :registered_at, :naive_datetime
      add :adopted_at, :naive_datetime
     ## add :animals_status_id, references("animal_statuses")
      timestamps()
    end

  end
end
