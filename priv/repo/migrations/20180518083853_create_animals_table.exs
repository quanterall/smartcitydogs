defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsTable do
  use Ecto.Migration

  def change do
    create table ("animals") do
      add :sex, :text, ["Male","Female"]
      add :chip_number, :text
      add :address, :text
      add :deleted_at, :naive_datetime
      add :registered_at, :naive_datetime
      add :adopted_at, :naive_datetime
      timestamps()
    end
  end
end
