defmodule Smartcitydogs.Repo.Migrations.CreateAnimalsTable do
  use Ecto.Migration

  def change do
    create table("animals") do
      add(:sex, :text, ["male", "female"])
      add(:chip_number, :text)
      add(:address, :text)
      add(:longitude, :float)
      add(:latitude, :float)
      add(:description, :text)
      add(:adopted_at, :utc_datetime)
      add(:animal_status_id, references("animal_statuses"))
      timestamps()
    end
  end
end
