defmodule Smartcitydogs.Repo.Migrations.CreateSignalsCommentsTable do
  use Ecto.Migration
<<<<<<< HEAD
  #add
  def change do
    create table("signals_comments") do
      add :comment, :text
      add :deleted_at, :naive_datetime
=======

  def change do
    create table("signals_comments") do
      add :deleted_at, :naive_datetime
      add :comment, :text
>>>>>>> 47a969967201770326403109a0880a25376daae6
      timestamps()
    end
  end
end
