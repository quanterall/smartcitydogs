defmodule Smartcitydogs.Repo.Migrations.SignalImages do
  use Ecto.Migration

  def change do
    create table(:signal_images) do
      add(:url, :text)
      add(:signals_id, references("signals"))
      timestamps()
    end
  end
end
