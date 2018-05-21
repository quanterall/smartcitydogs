defmodule Smartcitydogs.Repo.Migrations.CreateSignalsTable do
  use Ecto.Migration

  def change do
    create table("signals") do
      add :title, :text
      add :view_count, :integer
      add :address, :text
      add :support_count, :integer
      add :chip_number, :text
      add :description, :text
      add :deleted_at, :naive_datetime
      timestamps()
    end
  end
end
