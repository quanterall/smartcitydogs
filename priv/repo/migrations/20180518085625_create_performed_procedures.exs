defmodule Smartcitydogs.Repo.Migrations.CreatePerformedProcedures do
  use Ecto.Migration

  def change do
    create table("performed_procedures") do
      add :date, :naive_datetime
      timestamps()
    end
  end
end
