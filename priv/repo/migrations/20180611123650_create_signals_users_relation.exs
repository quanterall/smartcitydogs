defmodule Smartcitydogs.Repo.Migrations.CreateSignalsUsersRelation do
  use Ecto.Migration

  def change do
    alter table(:signals) do
      add(:users_id, references(:users))
    end
  end
end
