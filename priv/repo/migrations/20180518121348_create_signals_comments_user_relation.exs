defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCommentsUserRelation do
  use Ecto.Migration
  # add
  def change do
    alter table(:signals_comments) do
      add(:users_id, references(:users))
    end
  end
end
