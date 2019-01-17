defmodule Smartcitydogs.Repo.Migrations.AddPrefixToSignalTypes do
  use Ecto.Migration

  def change do
    alter table(:signal_types) do
      add(:prefix, :text)
    end

    alter table(:animal_statuses) do
      add(:prefix, :text)
    end

    alter table(:procedure_types) do
      add(:prefix, :text)
    end

    alter table(:user_types) do
      add(:prefix, :text)
    end
  end
end
