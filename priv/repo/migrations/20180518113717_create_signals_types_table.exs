defmodule Smartcitydogs.Repo.Migrations.CreateSignalsTypesTable do
  use Ecto.Migration

  def change do
    create table("signals_types") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
