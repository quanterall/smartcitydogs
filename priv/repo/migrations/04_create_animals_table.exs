defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsTable do
  use Ecto.Migration

  def change do
    create table("animals") do
      add(:sex, :text, ["Male", "Female"])
      add(:chip_number, :text)
      add(:address, :text)
      add(:longitude, :float)
      add(:latitude, :float)
      add(:description, :text)
      add(:deleted_at, :naive_datetime)
      add(:adopted_at, :naive_datetime)
      add(:animal_status_id, references("animal_statuses"))
      timestamps()
    end
  end
end
