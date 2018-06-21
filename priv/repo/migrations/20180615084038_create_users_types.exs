defmodule SmartCityDogs.Repo.Migrations.CreateUsersTypes do
  use Ecto.Migration

  def change do
    create table(:users_types) do
      add(:name, :text)
      add(:deleted_at, :naive_datetime)

      timestamps()
    end
  end
end
