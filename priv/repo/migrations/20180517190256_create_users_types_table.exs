defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table("users_types") do
      add :deleted_at, :naive_datetime
      add :title, :string
      add :name, :text
      timestamps
    end
  end
end
