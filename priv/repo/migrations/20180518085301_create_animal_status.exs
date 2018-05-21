defmodule Smartcitydogs.Repo.Migrations.CreateAnimalStatus do
  use Ecto.Migration

  def change do
    create table("animal_status") do
      add :name, :text
      timestamps()
    end
  end
end
