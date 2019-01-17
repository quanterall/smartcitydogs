defmodule Smartcitydogs.Repo.Migrations.CreateSignalLikesUniqueIndex do
  use Ecto.Migration

  def change do
    create(unique_index(:signal_likes, [:user_id, :signal_id], name: :users_signals_unique_like))
  end
end
