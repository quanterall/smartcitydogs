defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCommentsSignalRelation do
  use Ecto.Migration
  #add
  def change do
    alter table(:signals_comments) do
      add :signals_id, references(:signals)
    end
  end
end
