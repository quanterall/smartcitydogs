defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users_types") do
      add :title, :text
      add :name, :text
      add :deleted_at, :naive_datetime
      timestamps()
    end
  end
end
