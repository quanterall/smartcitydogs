defmodule Smartcitydogs.Repo.Migrations.Adopt do
  use Ecto.Migration

  def change do
    create table(:adopt) do
      add(:user_id, references("users"))
      add(:animal_id, references("animals"))
      timestamps()
    end
  end
end
