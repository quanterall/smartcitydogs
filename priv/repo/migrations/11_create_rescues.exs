defmodule Smartcitydogs.Repo.Migrations.Rescues do
  use Ecto.Migration

  def change do
    create table("rescues") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      add(:animal_id, references("animals"))
      timestamps()
    end
  end
end
