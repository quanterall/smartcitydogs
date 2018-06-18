defmodule SmartCityDogs.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :topic, :text
      add :text, :text

      timestamps()
    end

  end
end
