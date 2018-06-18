defmodule SmartCityDogs.Repo.Migrations.CreateSignals do
  use Ecto.Migration

  def change do
    create table(:signals) do
      add :title, :text
      add :view_count, :integer
      add :address, :text
      add :support_count, :integer
      add :chip_number, :text
      add :description, :text
      add :deleted_at, :naive_datetime
      add :signals_types_id, references("signals_types")
      add :signals_categories_id, references("signals_categories")
      add :users_id, references("users")

      timestamps()
    end

  end
end
