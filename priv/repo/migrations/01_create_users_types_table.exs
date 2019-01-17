defmodule Smartcitydogs.Repo.Migrations.UserTypes do
  use Ecto.Migration

  def up do
    create table("user_types") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
