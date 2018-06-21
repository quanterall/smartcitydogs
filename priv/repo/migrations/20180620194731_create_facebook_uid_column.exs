defmodule SmartCityDogs.Repo.Migrations.AddFacebookTokenColumn do
  use Ecto.Migration
  def change do
    alter table(:users) do
      add :facebook_uid, :text
    end
  end
end
