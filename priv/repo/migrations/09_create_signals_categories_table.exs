defmodule Smartcitydogs.Repo.Migrations.SignalCategories do
  use Ecto.Migration

  def change do
    create table("signal_category") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
