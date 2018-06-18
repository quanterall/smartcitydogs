defmodule SmartCityDogs.Repo.Migrations.CreateRescues do
  use Ecto.Migration

  def change do
    create table(:rescues) do
      add :name, :text
      add :deleted_at, :naive_datetime
    ##  add :animals_id, references("animals")
      timestamps()
    end

  end
end
