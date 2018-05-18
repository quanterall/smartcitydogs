defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table("users") do
      timestamps
      add :deleted_at, :naive_datetime
      add :title, :text
      add :username, :text
      add :password, :text
      add :name, :text
      add :family, :text
      add :email, :text
      add :phone, :text
    end
  end
end
