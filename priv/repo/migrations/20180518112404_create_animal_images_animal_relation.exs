defmodule Smartcitydogs.Repo.Migrations.CreateAnimalImagesAnimalRelation do
  use Ecto.Migration

  def change do
    alter table(:animal_images) do
      add :animal_id, references(:animal)
    end
  end
end
