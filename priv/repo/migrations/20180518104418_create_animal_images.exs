defmodule Smartcitydogs.Repo.Migrations.CreateAnimalImages do
  use Ecto.Migration

  def change do
    create table("animal_images") do
      add :deleted_at, :naive_datetime
      add :url, :text
      timestamps()
    end
  end
end
