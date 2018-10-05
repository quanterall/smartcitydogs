defmodule Smartcitydogs.Repo.Migrations.BlockchainTxAnimalsTable do
  use Ecto.Migration

  def change do
    create table("tx_hash_animals") do
      add(:tx_hash, :text)
      add(:animals_id, references("animals"))
      timestamps()
    end
  end
end