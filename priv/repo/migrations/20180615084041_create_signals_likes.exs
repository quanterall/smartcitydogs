defmodule Smartcitydogs.Repo.Migrations.CreateSignalsLikes do
  use Ecto.Migration

  def change do
    create table(:signals_likes) do
      add(:like, :integer)
      add(:deleted_at, :naive_datetime)
      add(:signals_id, references("signals"))
      add(:users_id, references("users"))
      timestamps()
    end
  end
end
