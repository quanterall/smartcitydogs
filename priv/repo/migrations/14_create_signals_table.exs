defmodule Smartcitydogs.Repo.Migrations.Signals do
  use Ecto.Migration

  def change do
    create table("signals") do
      add(:title, :text)
      add(:view_count, :integer, default: 0)
      add(:address, :text)
      add(:support_count, :integer, default: 0)
      add(:chip_number, :text)
      add(:description, :text)
      add(:deleted_at, :naive_datetime)
      add(:address_B, :float)
      add(:address_F, :float)
      add(:signals_categories_id, references("signals_categories"))
      add(:signals_types_id, references("signals_types"), default: 2)
      add(:users_id, references("users"))
      timestamps()
    end
  end
end
