defmodule Smartcitydogs.Repo.Migrations.CreateUsersUniqueIndex do
  use Ecto.Migration

  def change do
    create(unique_index(:users, [:email], name: :users_email))
  end
end
