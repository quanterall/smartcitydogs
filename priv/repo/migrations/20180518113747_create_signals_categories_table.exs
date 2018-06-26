defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCategoriesTable do
  use Ecto.Migration

  def change do
    create table("signals_categories") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end