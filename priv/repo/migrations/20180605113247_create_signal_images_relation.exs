defmodule Smartcitydogs.Repo.Migrations.CreateSignalImagesRelation do
  use Ecto.Migration

  def change do
    alter table(:signal_images) do
      add(:signal_id, references(:signals))
    end
  end
end
