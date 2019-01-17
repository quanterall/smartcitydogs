defmodule Smartcitydogs.Repo.Migrations.AnimalStatus do
  use Ecto.Migration

  def change do
    create table("animal_statuses") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
