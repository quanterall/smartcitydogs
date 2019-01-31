defmodule Smartcitydogs.Repo.Migrations.AnimalStatus do
  use Ecto.Migration

  def change do
    create table("animal_statuses") do
      add(:name, :text)
      timestamps()
    end
  end
end
