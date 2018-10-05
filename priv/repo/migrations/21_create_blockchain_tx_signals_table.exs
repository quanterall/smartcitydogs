defmodule Smartcitydogs.Repo.Migrations.BlockchainTxSignalsTable do
  use Ecto.Migration

  def change do
    create table("tx_hash_signals") do
      add(:tx_hash, :text)
      add(:signals_id, references("signals"))
      timestamps()
    end
  end
end