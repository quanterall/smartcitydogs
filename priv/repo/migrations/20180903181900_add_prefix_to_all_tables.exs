defmodule Smartcitydogs.Repo.Migrations.AddPrefixToSignalTypes do
  use Ecto.Migration

  def change do
    alter table(:signals_types) do
      add(:prefix, :text)
    end

    alter table(:animal_status) do
      add(:prefix, :text)
    end

    alter table(:procedure_type) do
      add(:prefix, :text)
    end

    alter table(:users_types) do
      add(:prefix, :text)
    end
  end
end
