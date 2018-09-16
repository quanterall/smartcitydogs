defmodule Smartcitydogs.Repo.Migrations.Adopt do
  use Ecto.Migration

  def change do
    create table(:adopt) do
      add(:users_id, references("users"))
      add(:animals_id, references("animals"))
      timestamps()
    end
  end
end
