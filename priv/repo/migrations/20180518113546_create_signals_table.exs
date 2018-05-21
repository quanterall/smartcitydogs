defmodule Smartcitydogs.Repo.Migrations.CreateSignalsTable do
  use Ecto.Migration

  def change do
    create table("signals") do
      add :deleted_at, :naive_datetime
      add :title, :text
      add :view_count, :integer
      add :adress, :text
      add :support_count, :integer
      add :chip_number, :text
      add :description, :text
      timestamps()
    end
  end
end
