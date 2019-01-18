defmodule Smartcitydogs.Repo.Migrations.Signal do
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
      add(:longitude, :float)
      add(:latitude, :float)
      add(:signal_category_id, references("signal_categories"))
      add(:signal_type_id, references("signal_types"), default: 2)
      add(:user_id, references("users"))
      timestamps()
    end
  end
end
