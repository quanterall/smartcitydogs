defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCategoryRelation do
  use Ecto.Migration

  def change do
    alter table(:signals) do
      add(:signals_categories_id, references(:signals_categories))
    end
  end
end
