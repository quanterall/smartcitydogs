defmodule Smartcitydogs.Repo.Migrations.CreateSignalsTypesTable do
  use Ecto.Migration

  def change do
    create table("signals_types") do
<<<<<<< HEAD
      add :name, :text
      add :deleted_at, :naive_datetime
      timestamps()
=======
      add :deleted_at, :naive_datetime
      add :name, :text
>>>>>>> 47a969967201770326403109a0880a25376daae6
    end
  end
end
