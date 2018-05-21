defmodule Smartcitydogs.Repo.Migrations.CreateHeaderSlidesTable do
  use Ecto.Migration

  def change do
    create table("header_slides") do
      add(:image_url, :text)
      add(:text, :text)

      timestamps()
    end
  end
end
