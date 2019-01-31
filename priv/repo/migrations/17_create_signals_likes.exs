defmodule Smartcitydogs.Repo.Migrations.SignalLike do
  use Ecto.Migration

  def change do
    create table(:signal_likes) do
      add(:like, :integer)
      add(:deleted_at, :naive_datetime)
      add(:signal_id, references("signals"))
      add(:user_id, references("users"))
      timestamps()
    end
  end
end
