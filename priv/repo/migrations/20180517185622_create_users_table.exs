defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table("users") do
      timestamps
      add(:deleted_at, :naive_datetime)
      add(:username, :text)
      add(:password_hash, :text)
      add(:fist_name, :text)
      add(:last_name, :text)
      add(:email, :text)
      add(:phone, :text)
    end
  end
end
