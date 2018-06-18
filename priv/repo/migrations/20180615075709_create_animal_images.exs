defmodule SmartCityDogs.Repo.Migrations.CreateAnimalImages do
  use Ecto.Migration

  def change do
    create table(:animal_images) do
      add :url, :text
      add :deleted_at, :naive_datetime
   ##   add :animals_id, references("animals")
      timestamps()
    end

  end
end
