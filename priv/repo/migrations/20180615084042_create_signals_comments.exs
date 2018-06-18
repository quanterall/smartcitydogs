defmodule SmartCityDogs.Repo.Migrations.CreateSignalsComments do
  use Ecto.Migration

  def change do
    create table(:signals_comments) do
      add :comment, :text
      add :deleted_at, :naive_datetime
      add :signals_id, references("signals")
      add :users_id, references("users")

      timestamps()
    end

  end
end
