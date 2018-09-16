defmodule Smartcitydogs.Repo.Migrations.SignalsImages do
  use Ecto.Migration

  def change do
    create table(:signals_images) do
      add(:url, :text)
      add(:signals_id, references("signals"))
      timestamps()
    end
  end
end
