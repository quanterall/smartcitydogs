defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table("users_types") do
      timestamps()
      add(:deleted_at, :naive_datetime)
      add(:name, :text)
    end
  end
end
