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
      add(:signal_category_id, references("signal_category"))
      add(:signal_type_id, references("signal_types"), default: 2)
      add(:user_id, references("users"))
      timestamps()
    end
  end
end
