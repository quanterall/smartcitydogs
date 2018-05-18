defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :text
      add :password, :text
      add :name, :text
      add :family, :text
      add :email, :text
      add :phone, :text
      add :deleted_at, :naive_datetime
      timestamps()
    end
  end
end
