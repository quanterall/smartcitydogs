defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsAnimalStatusRelation do
  use Ecto.Migration

  def change do
    alter table(:animals) do
      add(:animals_status_id, references(:animal_status))
    end
  end
end
