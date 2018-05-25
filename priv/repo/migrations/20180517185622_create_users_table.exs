defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table("users") do
      add(:username, :text)
      add(:password_hash, :text)
      add(:first_name, :text)
      add(:last_name, :text)
      add(:email, :text)
      add(:phone, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
