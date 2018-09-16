defmodule Smartcitydogs.Repo.Migrations.CreateSignalsLikesUniqueIndex do
  use Ecto.Migration

  def change do
    create(
      unique_index(:signals_likes, [:users_id, :signals_id], name: :users_signals_unique_like)
    )
  end
end
