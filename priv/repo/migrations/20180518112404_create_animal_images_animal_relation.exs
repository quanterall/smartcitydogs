defmodule Smartcitydogs.Repo.Migrations.CreateAnimalImagesAnimalRelation do
  use Ecto.Migration

  def change do
    alter table(:animal_images) do
      add(:animals_id, references(:animals))
    end
  end
end
