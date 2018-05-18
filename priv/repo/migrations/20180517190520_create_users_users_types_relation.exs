defmodule Smartcitydogs.Repo.Migrations.CreateUsersUsersTypesRelation do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :users_types_id, references(:users_types)
    end
  end
end
