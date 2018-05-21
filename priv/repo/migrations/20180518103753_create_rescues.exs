defmodule Smartcitydogs.Repo.Migrations.CreateRescues do
  use Ecto.Migration

  def change do
    create table("rescues") do
      add(:name, :text)
      timestamps()
    end
  end
end
