defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsTable do
  use Ecto.Migration

  def change do
    create table ("animals") do
      add :deleted_at, :naive_datetime
      add :registered_at, :naive_datetime
      add :adopted_at, :naive_datetime
      add :sex, :value, ["m", "f"]
      add :chip_number, :text
      add :address, :text
      timestamps()
    end
  end
end
