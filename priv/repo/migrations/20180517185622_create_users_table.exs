defmodule Smartcitydogs.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    create table("users") do
      add(:username, :text)
      add(:password_hash, :text)
      add(:first_name, :text)
      add(:last_name, :text)
      add(:email, :text)
      add(:phone, :text)
      add(:reset_password_token, :text)
      add(:reset_token_sent_at, :naive_datetime)
      add(:deleted_at, :naive_datetime)
      add(:liked_signals, {:array, :string})
      add(:liked_comments, {:array, :string})
      add(:disliked_comments, {:array, :string})
      ## add(:contact, :json)
      timestamps()
    end
  end
end
