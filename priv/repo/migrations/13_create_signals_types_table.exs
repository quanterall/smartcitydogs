defmodule Smartcitydogs.Repo.Migrations.SignalType do
  use Ecto.Migration

  def change do
    create table("signal_types") do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
