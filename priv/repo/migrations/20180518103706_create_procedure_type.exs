defmodule Smartcitydogs.Repo.Migrations.CreateProcedureType do
  use Ecto.Migration

  def change do
    create table("procedure_type") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
