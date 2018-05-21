defmodule Smartcitydogs.Repo.Migrations.CreateSignalsTypeRelation do
  use Ecto.Migration

  def change do
    alter table(:signals) do
      add(:signals_types_id, references(:signals_types))
    end
  end
end
