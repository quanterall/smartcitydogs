defmodule Smartcitydogs.Repo.Migrations.CreateSignalImages do
  use Ecto.Migration

  def change do
    create table("signal_images") do
      add(:url, :text)
      timestamps()
    end
  end
end
