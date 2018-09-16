defmodule Smartcitydogs.Repo.Migrations.SignalsComments do
  use Ecto.Migration
  # add
  def change do
    create table("signals_comments") do
      add(:comment, :text)
      add(:likes_number, :integer)
      add(:deleted_at, :naive_datetime)
      add(:signals_id, references("signals"))
      add(:users_id, references("users"))
      timestamps()
    end
  end
end
