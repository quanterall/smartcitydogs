defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCategoriesTable do
  use Ecto.Migration

  def change do
    create table("signals_categories") do
      add :deleted_at, :naive_datetime
      add :name, :text
    end
  end
end
