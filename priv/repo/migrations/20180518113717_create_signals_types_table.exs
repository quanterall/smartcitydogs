defmodule Smartcitydogs.Repo.Migrations.CreateSignalsTypesTable do
  use Ecto.Migration

  def change do
    create table("signals_types") do
      add :deleted_at, :naive_datetime
      add :name, :text
    end
  end
end
