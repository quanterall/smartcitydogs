defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsRescuesRelation do
  use Ecto.Migration

  def change do
    alter table(:rescues) do
      add :animals_id, references(:animals)
    end
  end
end
