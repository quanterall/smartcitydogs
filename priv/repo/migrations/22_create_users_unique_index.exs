defmodule Smartcitydogs.Repo.Migrations.CreateUsersUniqueIndex do
  use Ecto.Migration

  def change do
    create(unique_index(:users, [:email], name: :users_email))
    create(unique_index(:signal_types, [:prefix], name: :signal_type_prefix))
    create(unique_index(:signal_categories, [:prefix], name: :signal_category_prefix))
  end
end
