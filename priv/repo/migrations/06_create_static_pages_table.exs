defmodule Smartcitydogs.Repo.Migrations.StaticPages do
  use Ecto.Migration

  def change do
    create table("static_pages") do
      add(:title, :text)
      add(:meta, :text)
      add(:keywords, :text)
      add(:content, :text)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
