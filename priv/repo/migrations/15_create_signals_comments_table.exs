defmodule Smartcitydogs.Repo.Migrations.SignalComments do
  use Ecto.Migration
  # add
  def change do
    create table("signal_comments") do
      add(:comment, :text)
      add(:likes_number, :integer)
      add(:deleted_at, :naive_datetime)
      add(:signal_id, references("signals"))
      add(:user_id, references("users"))
      timestamps()
    end
  end
end
