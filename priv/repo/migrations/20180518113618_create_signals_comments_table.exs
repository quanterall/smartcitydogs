defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCommentsTable do
  use Ecto.Migration

  def change do
    create table("signals_comments") do
      add :deleted_at, :naive_datetime
      add :comment, :text
      timestamps()
    end
  end
end
