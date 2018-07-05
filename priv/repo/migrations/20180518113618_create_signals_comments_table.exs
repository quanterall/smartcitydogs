defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCommentsTable do
  use Ecto.Migration
  # add
  def change do
    create table("signals_comments") do
      add(:comment, :text)
      add(:likes_number, :integer)
      add(:deleted_at, :naive_datetime)
      timestamps()
    end
  end
end
