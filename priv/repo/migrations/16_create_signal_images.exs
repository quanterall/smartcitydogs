defmodule Smartcitydogs.Repo.Migrations.SignalsImages do
  use Ecto.Migration

  def change do
    create table(:signal_images) do
      add(:url, :text)
      add(:signal_id, references("signals"))
      timestamps()
    end
  end
end
