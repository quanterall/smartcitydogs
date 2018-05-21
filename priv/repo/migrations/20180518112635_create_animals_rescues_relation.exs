defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsRescuesRelation do
  use Ecto.Migration

  def change do
    alter table(:rescues) do
      add :animal_id, references(:animal)
    end
  end
end
