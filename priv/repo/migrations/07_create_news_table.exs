defmodule Smartcitydogs.Repo.Migrations.News do
  use Ecto.Migration

  def change do
    create table("news") do
      add(:image_url, :text)
      add(:title, :text)
      add(:content, :text)
      add(:short_content, :text)
      add(:date, :naive_datetime)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
