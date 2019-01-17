defmodule Smartcitydogs.Repo.Migrations.AnimalImages do
  use Ecto.Migration

  def change do
    create table("animal_images") do
      add(:url, :text)
      add(:deleted_at, :naive_datetime)
      add(:animal_id, references("animals"))
      timestamps()
    end
  end
end
