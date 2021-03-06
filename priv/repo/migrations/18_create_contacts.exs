defmodule Smartcitydogs.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add(:topic, :text)
      add(:text, :text)
      add(:user_id, references("users"))
      timestamps()
    end
  end
end
