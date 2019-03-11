defmodule Smartcitydogs.Repo.Migrations.Blockchain do
  use Ecto.Migration

  def change do
    create table(:blockchain_hashes) do
      add(:table_id, :integer)
      add(:table_name, :text)
      add(:hash, :text)
      add(:key, :text)
      timestamps()
    end

    create(unique_index(:blockchain_hashes, [:hash]))
  end
end
